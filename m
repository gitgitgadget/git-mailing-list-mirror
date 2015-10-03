From: Ray Donnelly <mingw.android@gmail.com>
Subject: Re: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Sat, 3 Oct 2015 16:38:47 +0100
Message-ID: <CAOYw7dvYvgXWNi=kFdB0kXP0BjGTmcY-dG6mkaKU93LdV4i5HQ@mail.gmail.com>
References: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b450d548502b00521351373
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ray Donnelly <mingw.android@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 17:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiOth-00088N-Ur
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 17:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbJCPit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 11:38:49 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34559 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbbJCPis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 11:38:48 -0400
Received: by obbda8 with SMTP id da8so102013409obb.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mhfDv/GDTWEMGqTlQodTeTmEmlh2ZajC3Svy6IXs/Sg=;
        b=eJhdMv7yIK2//1Uon1y/gjlFxS74QqNzEUFj59idyz4B8K5QqGm+JvONL99Tpw8qSN
         W+vNcwNwk2y+XxfXE0tmZ4lLPpPN7589PYO3nw3Xq3WKTnifb3Aatj9/LlBuTqXkewIC
         wnX+eamPCTxJyO2UiBHYuJQMKqd4157fVCOtqj6fR3SbqVKFJk5TKcbGvGqcGcinTIhH
         jJAhqSB3Gjwy1K9nK7slVkMZfBOs4qKxtOZu4Tmm0BHncSTo8lEPFJO7twAM/Z7RKqIQ
         bDfDEfEsGLfEMEfnqPPkuASdNoYHvDt3Jj3bqnDhAA1FWGqaYZ5vpes7DskvqpkN4fJV
         RpNw==
X-Received: by 10.60.141.130 with SMTP id ro2mr4005987oeb.9.1443886728005;
 Sat, 03 Oct 2015 08:38:48 -0700 (PDT)
Received: by 10.202.15.21 with HTTP; Sat, 3 Oct 2015 08:38:47 -0700 (PDT)
In-Reply-To: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278972>

--047d7b450d548502b00521351373
Content-Type: text/plain; charset=UTF-8

I'm going to have to attach this as a file, git-send-email isn't
working for me; apologies.

On Sat, Oct 3, 2015 at 1:44 PM, Ray Donnelly <mingw.android@gmail.com> wrote:
> In normalize_ceiling_entry(), we test that normalized paths end with
> slash, *unless* the path to be normalized was already the root
> directory.
>
> However, normalize_path_copy() does not even enforce this condition.
>
> Even worse: on Windows, the root directory gets translated into a
> Windows directory by the Bash before being passed to `git.exe` (or
> `test-path-utils.exe`), which means that we cannot even know whether
> the path that was passed to us was the root directory to begin with.
>
> This issue has already caused endless hours of trying to "fix" the
> MSYS2 runtime, only to break other things due to MSYS2 ensuring that
> the converted path maintains the same state as the input path with
> respect to any final '/'.
>
> So let's just forget about this test. It is non-essential to Git's
> operation, anyway.
>
> Ack-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Ray Donnelly <mingw.android@gmail.com>
> ---
>  test-path-utils.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/test-path-utils.c b/test-path-utils.c
> index 3dd3744..c67bf65 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -21,8 +21,6 @@ static int normalize_ceiling_entry(struct
> string_list_item *item, void *unused)
>   if (normalize_path_copy(buf, ceil) < 0)
>   die("Path \"%s\" could not be normalized", ceil);
>   len = strlen(buf);
> - if (len > 1 && buf[len-1] == '/')
> - die("Normalized path \"%s\" ended with slash", buf);
>   free(item->string);
>   item->string = xstrdup(buf);
>   return 1;
> --
> 2.5.2

--047d7b450d548502b00521351373
Content-Type: application/octet-stream; 
	name="0001-test-path-utils.c-remove-incorrect-assumption.patch"
Content-Disposition: attachment; 
	filename="0001-test-path-utils.c-remove-incorrect-assumption.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ifb8vidt0

RnJvbSAzZGVlYTEyZGQ4NTA2Zjg4ZmRhZWFiY2MzMzY4M2Y4MWI3NWExM2ZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXkgRG9ubmVsbHkgPG1pbmd3LmFuZHJvaWRAZ21haWwuY29t
PgpEYXRlOiBUaHUsIDEgT2N0IDIwMTUgMjA6MDQ6MTcgKzAxMDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gdGVzdC1wYXRoLXV0aWxzLmM6IHJlbW92ZSBpbmNvcnJlY3QgYXNzdW1wdGlvbgoKSW4gbm9y
bWFsaXplX2NlaWxpbmdfZW50cnkoKSwgd2UgdGVzdCB0aGF0IG5vcm1hbGl6ZWQgcGF0aHMgZW5k
IHdpdGgKc2xhc2gsICp1bmxlc3MqIHRoZSBwYXRoIHRvIGJlIG5vcm1hbGl6ZWQgd2FzIGFscmVh
ZHkgdGhlIHJvb3QKZGlyZWN0b3J5LgoKSG93ZXZlciwgbm9ybWFsaXplX3BhdGhfY29weSgpIGRv
ZXMgbm90IGV2ZW4gZW5mb3JjZSB0aGlzIGNvbmRpdGlvbi4KCkV2ZW4gd29yc2U6IG9uIFdpbmRv
d3MsIHRoZSByb290IGRpcmVjdG9yeSBnZXRzIHRyYW5zbGF0ZWQgaW50byBhCldpbmRvd3MgZGly
ZWN0b3J5IGJ5IHRoZSBCYXNoIGJlZm9yZSBiZWluZyBwYXNzZWQgdG8gYGdpdC5leGVgIChvcgpg
dGVzdC1wYXRoLXV0aWxzLmV4ZWApLCB3aGljaCBtZWFucyB0aGF0IHdlIGNhbm5vdCBldmVuIGtu
b3cgd2hldGhlcgp0aGUgcGF0aCB0aGF0IHdhcyBwYXNzZWQgdG8gdXMgd2FzIHRoZSByb290IGRp
cmVjdG9yeSB0byBiZWdpbiB3aXRoLgoKVGhpcyBpc3N1ZSBoYXMgYWxyZWFkeSBjYXVzZWQgZW5k
bGVzcyBob3VycyBvZiB0cnlpbmcgdG8gImZpeCIgdGhlCk1TWVMyIHJ1bnRpbWUsIG9ubHkgdG8g
YnJlYWsgb3RoZXIgdGhpbmdzIGR1ZSB0byBNU1lTMiBlbnN1cmluZyB0aGF0CnRoZSBjb252ZXJ0
ZWQgcGF0aCBtYWludGFpbnMgdGhlIHNhbWUgc3RhdGUgYXMgdGhlIGlucHV0IHBhdGggd2l0aApy
ZXNwZWN0IHRvIGFueSBmaW5hbCAnLycuCgpTbyBsZXQncyBqdXN0IGZvcmdldCBhYm91dCB0aGlz
IHRlc3QuIEl0IGlzIG5vbi1lc3NlbnRpYWwgdG8gR2l0J3MKb3BlcmF0aW9uLCBhbnl3YXkuCgpB
Y2stYnk6IEpvaGFubmVzIFNjaGluZGVsaW4gPGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRlPgpT
aWduZWQtb2ZmLWJ5OiBSYXkgRG9ubmVsbHkgPG1pbmd3LmFuZHJvaWRAZ21haWwuY29tPgotLS0K
IHRlc3QtcGF0aC11dGlscy5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdC1wYXRoLXV0aWxzLmMgYi90ZXN0LXBhdGgtdXRpbHMuYwppbmRl
eCAzZGQzNzQ0Li5jNjdiZjY1IDEwMDY0NAotLS0gYS90ZXN0LXBhdGgtdXRpbHMuYworKysgYi90
ZXN0LXBhdGgtdXRpbHMuYwpAQCAtMjEsOCArMjEsNiBAQCBzdGF0aWMgaW50IG5vcm1hbGl6ZV9j
ZWlsaW5nX2VudHJ5KHN0cnVjdCBzdHJpbmdfbGlzdF9pdGVtICppdGVtLCB2b2lkICp1bnVzZWQp
CiAJaWYgKG5vcm1hbGl6ZV9wYXRoX2NvcHkoYnVmLCBjZWlsKSA8IDApCiAJCWRpZSgiUGF0aCBc
IiVzXCIgY291bGQgbm90IGJlIG5vcm1hbGl6ZWQiLCBjZWlsKTsKIAlsZW4gPSBzdHJsZW4oYnVm
KTsKLQlpZiAobGVuID4gMSAmJiBidWZbbGVuLTFdID09ICcvJykKLQkJZGllKCJOb3JtYWxpemVk
IHBhdGggXCIlc1wiIGVuZGVkIHdpdGggc2xhc2giLCBidWYpOwogCWZyZWUoaXRlbS0+c3RyaW5n
KTsKIAlpdGVtLT5zdHJpbmcgPSB4c3RyZHVwKGJ1Zik7CiAJcmV0dXJuIDE7Ci0tIAoyLjUuMgoK
--047d7b450d548502b00521351373--
