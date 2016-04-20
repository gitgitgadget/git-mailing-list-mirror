From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 2/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 22:03:59 +0200
Message-ID: <ADDF0944-7EBE-4DCC-B4D9-F4662AEFBEC7@gmail.com>
References: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com> <1461139809-6573-3-git-send-email-larsxschneider@gmail.com> <CAHGBnuOjb+zmzwJeY-hbU4MYKpOMCQSRtDC4hS4zvCD5DQzv3w@mail.gmail.com> <xmqq8u08w2tb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 22:04:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asyMS-0006s5-KW
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 22:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbcDTUEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 16:04:07 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35150 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcDTUEG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 16:04:06 -0400
Received: by mail-wm0-f53.google.com with SMTP id e201so63248990wme.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lzCklxRFlZql7UweaXnznVoOOhdhZgHuhnZQ9tATu9g=;
        b=WUip673zz6HWk5vAcR7kNquIKSWBTj1iXOByJiBG8vca22WFXZLXzgGMsxuwlgowsU
         C69HIJ0rtHFa7SHp6lu1zIbUBslji1sM1+nF7fwln75YOy7+99/zfMt+AQS/d9Ion3AI
         D+gGT+iWrsMmYj/6iFZ+GtvuXDGF32UU2Qw+L9+12BKIhBONruPABrasTHzGARDI/VIL
         PWYsT4EyK6Qthwfw6KQpa0XSsC99i4686IeRNDbMt2LottG/byDUJ+d8u00h6F+nfbGx
         453Tib1pq3DAOS3y0rbwuCRuJHOih8xYMw/imjYLfbyJXxnf+2ahaERxX56oPqgFg9O3
         i7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lzCklxRFlZql7UweaXnznVoOOhdhZgHuhnZQ9tATu9g=;
        b=C9ZsrPm8uWh5mjG5jnWSJ4KrjqHxPNUjRq92eVHIEuuZoiSWaHT1d/2GXrr5tKgyse
         HI82o02ciFO5mKpgxPGf87whT5expgGbhhAqJX5p519gddlbSEzxPmZUo46qPeXNoaMC
         FioU6qc8xABhOuqThvfcXfBmilZdrnxKhcN7xlo3unfedeSMTfEape8t1N50uES364RF
         IvE/UataMKuma1a5jOi+lvko2Wn5yJvYpA3Vm1sQaG36yc/k/q/NAFBx1XsEDg4urcK1
         SbsILVPHy0w8Nq02/e6FuhcGM473ZzRF8j5rzEB4nim5fs6eqpaJJ0HeJcj13Lkdss6r
         0DJw==
X-Gm-Message-State: AOPr4FXt/0qMAeclE4oP41enujHy2GaII1AswiA4dJpyoNW0cHrrJpI1OxH944gRhRSrdQ==
X-Received: by 10.28.145.67 with SMTP id t64mr11633282wmd.56.1461182642808;
        Wed, 20 Apr 2016 13:04:02 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BAD5D.dip0.t-ipconnect.de. [80.139.173.93])
        by smtp.gmail.com with ESMTPSA id ry15sm7210783wjb.19.2016.04.20.13.04.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 13:04:01 -0700 (PDT)
In-Reply-To: <xmqq8u08w2tb.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292069>


On 20 Apr 2016, at 20:30, Junio C Hamano <gitster@pobox.com> wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
>> Why do we need to remove the preamble at all, if present?

Because I need the content of a valid Git LFS pointer file 
a few lines below:
https://github.com/larsxschneider/git/blob/5ee7601c49b6eaa9da5eb47db5cf12b5d8d672c9/git-p4.py#L1085

This pointer file content is then written to the Git repository 
instead of the actual file content.


>> If all we
>> want is the oid, we should simply only look at the line that starts
>> with that keyword, which would skip any preamble. Which is what you
>> already do here. However, I'd probably use .splitlines() instead of
>> .split('\n') and .startswith('oid ') (note the trailing space) instead
>> of .startswith('oid') to ensure "oid" is a separate word.
>> 
>> But then again, I wonder why there's so much split() logic involved in
>> extracting the oid. Couldn't we replace all of that with a regexp like
>> 
>> oid = re.search(r"^oid \w+:(\w+)", pointerFile, re.MULTILINE).group(1)
> 
> Yup, all of that is a very useful suggestion.  If we know how the
> piece of information we want is identified in the output,
> specifically looking for it would future-proof the code better, as
> it will not be affected by future change that adds unexpected cruft
> to the output we are reading from.

I agree that this is a better solution.

@Junio: Can you squash the patch below or do you prefer a v3?

Thanks,
Lars


diff --git a/git-p4.py b/git-p4.py
index ab52bc3..a0d529b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1073,8 +1073,7 @@ class GitLFS(LargeFileSystem):
         if pointerFile.startswith(preamble):
             pointerFile = pointerFile[len(preamble):]

-        oidEntry = [i for i in pointerFile.split('\n') if i.startswith('oid')]
-        oid = oidEntry[0].split(' ')[1].split(':')[1]
+        oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
         localLargeFile = os.path.join(
             os.getcwd(),
             '.git', 'lfs', 'objects', oid[:2], oid[2:4],