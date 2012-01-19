From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Making pathspec limited log play nicer with --first-parent
Date: Thu, 19 Jan 2012 12:15:53 -0800
Message-ID: <CA+55aFxucaeX7it_Kj7WV3ZbwCukN+wvbuxqJzh3V5Rxz4ib1g@mail.gmail.com>
References: <7v1uqvjwga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5a4ce5e330204b6e73c87
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 21:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnyPD-00027K-Qk
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 21:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769Ab2ASUQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 15:16:15 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53617 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab2ASUQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 15:16:14 -0500
Received: by werb13 with SMTP id b13so278140wer.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=a1AZBil1LSS7qX3oJAu14Cl5Uawi/gXZgQ+rPi+OCEw=;
        b=ZkOSws2Lj1vW/gABVZTpJ1c/w1rQK25AJWjG1F6vOnISf0GCZSfDFKw5TVRdO5t3kq
         9InjBcf0Rp8YDOkZBp67fs0QMxv3czEfJjRGW+qSV2dRLdUBvAEKVK3URaqE8C3L3FMb
         DelLrtu5mIHheEz0TtEOUgXgVdlu5oYOWlWCA=
Received: by 10.216.131.106 with SMTP id l84mr11771090wei.29.1327004173349;
 Thu, 19 Jan 2012 12:16:13 -0800 (PST)
Received: by 10.216.63.135 with HTTP; Thu, 19 Jan 2012 12:15:53 -0800 (PST)
In-Reply-To: <7v1uqvjwga.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: dE5PbEYB9hz5qqmvDKlfoC5J-_M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188832>

--001636c5a4ce5e330204b6e73c87
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jan 19, 2012 at 11:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Comments?

Looks conceptually right, but I do have to admit to hating that new variable.

I don't see a better way to do it, though. Sure, you could do it with just

   if (revs->first_parent_only && pp != &commit->parents)
             break;

and avoid the new variable that way, but that replaces the annoying
variable with a pretty subtle thing.

Or we could re-write that while() loop and move the 'parent' variable
into it. Like the appended untested thing.

But maybe your patch is better, and my dislike for that parent counter
is just irrational.

                  Linus

--001636c5a4ce5e330204b6e73c87
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxm7zpn80

IHJldmlzaW9uLmMgfCAgIDE2ICsrKysrKysrKystLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9yZXZpc2lvbi5jIGIv
cmV2aXNpb24uYwppbmRleCAwNjRlMzUxMDg0NzguLjVlOGViMzc5YzM2OSAxMDA2NDQKLS0tIGEv
cmV2aXNpb24uYworKysgYi9yZXZpc2lvbi5jCkBAIC00MTUsNyArNDE1LDcgQEAgc3RhdGljIGlu
dCByZXZfc2FtZV90cmVlX2FzX2VtcHR5KHN0cnVjdCByZXZfaW5mbyAqcmV2cywgc3RydWN0IGNv
bW1pdCAqY29tbWl0KQogCiBzdGF0aWMgdm9pZCB0cnlfdG9fc2ltcGxpZnlfY29tbWl0KHN0cnVj
dCByZXZfaW5mbyAqcmV2cywgc3RydWN0IGNvbW1pdCAqY29tbWl0KQogewotCXN0cnVjdCBjb21t
aXRfbGlzdCAqKnBwLCAqcGFyZW50OworCXN0cnVjdCBjb21taXRfbGlzdCAqKnBwOwogCWludCB0
cmVlX2NoYW5nZWQgPSAwLCB0cmVlX3NhbWUgPSAwOwogCiAJLyoKQEAgLTQ0MSw4ICs0NDEsMTQg
QEAgc3RhdGljIHZvaWQgdHJ5X3RvX3NpbXBsaWZ5X2NvbW1pdChzdHJ1Y3QgcmV2X2luZm8gKnJl
dnMsIHN0cnVjdCBjb21taXQgKmNvbW1pdCkKIAkJcmV0dXJuOwogCiAJcHAgPSAmY29tbWl0LT5w
YXJlbnRzOwotCXdoaWxlICgocGFyZW50ID0gKnBwKSAhPSBOVUxMKSB7Ci0JCXN0cnVjdCBjb21t
aXQgKnAgPSBwYXJlbnQtPml0ZW07CisJZG8geworCQlzdHJ1Y3QgY29tbWl0X2xpc3QgKnBhcmVu
dCA9ICpwcDsKKwkJc3RydWN0IGNvbW1pdCAqcDsKKworCQlpZiAoIXBhcmVudCkKKwkJCWJyZWFr
OworCQlwcCA9ICZwYXJlbnQtPm5leHQ7CisJCXAgPSBwYXJlbnQtPml0ZW07CiAKIAkJaWYgKHBh
cnNlX2NvbW1pdChwKSA8IDApCiAJCQlkaWUoImNhbm5vdCBzaW1wbGlmeSBjb21taXQgJXMgKGJl
Y2F1c2Ugb2YgJXMpIiwKQEAgLTQ1OCw3ICs0NjQsNiBAQCBzdGF0aWMgdm9pZCB0cnlfdG9fc2lt
cGxpZnlfY29tbWl0KHN0cnVjdCByZXZfaW5mbyAqcmV2cywgc3RydWN0IGNvbW1pdCAqY29tbWl0
KQogCQkJCSAqIHRvIGxvc2UgdGhlIG90aGVyIGJyYW5jaGVzIG9mIHRoaXMKIAkJCQkgKiBtZXJn
ZSwgc28gd2UganVzdCBrZWVwIGdvaW5nLgogCQkJCSAqLwotCQkJCXBwID0gJnBhcmVudC0+bmV4
dDsKIAkJCQljb250aW51ZTsKIAkJCX0KIAkJCXBhcmVudC0+bmV4dCA9IE5VTEw7CkBAIC00ODcs
MTEgKzQ5MiwxMCBAQCBzdGF0aWMgdm9pZCB0cnlfdG9fc2ltcGxpZnlfY29tbWl0KHN0cnVjdCBy
ZXZfaW5mbyAqcmV2cywgc3RydWN0IGNvbW1pdCAqY29tbWl0KQogCQljYXNlIFJFVl9UUkVFX09M
RDoKIAkJY2FzZSBSRVZfVFJFRV9ESUZGRVJFTlQ6CiAJCQl0cmVlX2NoYW5nZWQgPSAxOwotCQkJ
cHAgPSAmcGFyZW50LT5uZXh0OwogCQkJY29udGludWU7CiAJCX0KIAkJZGllKCJiYWQgdHJlZSBj
b21wYXJlIGZvciBjb21taXQgJXMiLCBzaGExX3RvX2hleChjb21taXQtPm9iamVjdC5zaGExKSk7
Ci0JfQorCX0gd2hpbGUgKCFyZXZzLT5maXJzdF9wYXJlbnRfb25seSk7CiAJaWYgKHRyZWVfY2hh
bmdlZCAmJiAhdHJlZV9zYW1lKQogCQlyZXR1cm47CiAJY29tbWl0LT5vYmplY3QuZmxhZ3MgfD0g
VFJFRVNBTUU7Cg==
--001636c5a4ce5e330204b6e73c87--
