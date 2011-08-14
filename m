From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] revert: Fix buffer overflow in insn sheet parser
Date: Sun, 14 Aug 2011 19:37:20 +0530
Message-ID: <CALkWK0k46KPCZEeOrSHS22Ay-mGt+QPqiZetrc9V1YnhecDPUQ@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-3-git-send-email-artagnon@gmail.com> <20110814115821.GC18466@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 16:07:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsbLt-0004ai-Po
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 16:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab1HNOHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 10:07:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47249 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1HNOHl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 10:07:41 -0400
Received: by wyg24 with SMTP id 24so3028267wyg.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HF9ma+f8N8sxIV7q2SsnopYip7b09aZxYWb9453zYPA=;
        b=Of3qcaVw7UXdPk/M+FPjkzarZstdF8vSA2cecQ96p4TqHqLjd492L4HIh2LmclUWOb
         V8hd/VgM9whfT1Gu24DPzcz+cQgQ36PnLdXJGABsmpFrmBuBcrpYdxYNHlm68j9bR301
         mMqmT+FA32XTM6EvDcJHVGtssd/9PYLY5Khyw=
Received: by 10.216.131.134 with SMTP id m6mr2006183wei.78.1313330860176; Sun,
 14 Aug 2011 07:07:40 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sun, 14 Aug 2011 07:07:20 -0700 (PDT)
In-Reply-To: <20110814115821.GC18466@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179327>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
>> @@ -211,4 +211,15 @@ test_expect_success 'malformed instruction shee=
t 2' '
>> [...]
>> + =C2=A0 =C2=A0 sed "s/pick \([0-9a-f]\+\)\(.*\)/pick \1\1\1\1\1\1\1=
\1\2/" .git/sequencer/todo >new_sheet &&
>
> This construct (\+ in sed regexes) is not portable. =C2=A0See the not=
e on
> grep in Documentation/CodingGuidelines

I see.  Could you show me how to do it right?  My regex-foo is pretty
weak, and I don't know what else to do.

> (maybe it should be tweaked to
> say "grep and sed").

Okay.  Do you like this?

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
-- 8< --
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index fe1c1e5..0a843ea 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -69,8 +69,8 @@ For shell scripts specifically (not exhaustive):
  - We do not write the noiseword "function" in front of shell
    functions.

- - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
-   [::], [=3D=3D], nor [..]) for portability.
+ - As to use of grep and sed, stick to a subset of BRE (namely, no
+   \{m,n\}, [::], [=3D=3D], nor [..]) for portability.

    - We do not use \{m,n\};

-- Ram
