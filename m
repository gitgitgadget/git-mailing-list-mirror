From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3 3/3] git-p4: fix Git LFS pointer parsing
Date: Mon, 25 Apr 2016 09:35:48 +0200
Message-ID: <CAHGBnuO16Y2b3G5pyuG59b+vojRGe_wySmUcAUka9eT2opABdA@mail.gmail.com>
References: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
	<1461524292-20490-4-git-send-email-larsxschneider@gmail.com>
	<CAHGBnuMs6h478FXGA_x2nP1D6BJCxGzhumR_xq5JFmNgzM6Sdw@mail.gmail.com>
	<8340C6E5-C774-46EE-A1F9-1C4C7DF9CEB9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, ben.woosley@gmail.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 09:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aub3h-0003kU-KE
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 09:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbcDYHfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 03:35:50 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34566 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbcDYHft (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 03:35:49 -0400
Received: by mail-yw0-f195.google.com with SMTP id i22so23715257ywc.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=P41VFGhcVfOmHcNa8+YyImpNuMbDs1p2JL1sJFLjfqw=;
        b=zw5AlhCQIMADWEitRldJcBMSWxqLOJh5Knjg1nSUc5zk8N7StMHKI52lJd7AcFb/yP
         8X+pKSs+t6oAOCunKHCE8SvsIhYVt9I04zmItx85EXQZTlZf4aEypQ2KEegXFVrZFP1W
         LwzQ3Or7uRt9Grfpp47tb6E9uwP1NS25icIVdj4YWGGCWhKw7qwEye0UeImK+l+JbSis
         Qns1GN41wLI6aGczdK3aHyymZZ1BTPEj/FxQJlYRLqaBI2KdUxfgNbw6K6B6Wh/OGAB6
         9/JjrOjTGhrH2C57A34N6D+neLgjta7RkbR/uBd6zqrNwXqpStu8uuZrE1x2QiV7dWKz
         rreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=P41VFGhcVfOmHcNa8+YyImpNuMbDs1p2JL1sJFLjfqw=;
        b=V/SzIUrekdtaSDwMPhfJy1fVMWd4JiQbWmlEptP2qM70oTic2ala5Jd4FfMsKYQ/5R
         Xfw/LQAjWbBYLERMPYuk1YUPuNrLAZ4OXceDQ+QS4P7J8ko+k6e4HtTD7hq0x7s7QHd0
         Kv1a31fb2fm6z4W2NZw9AOH5UwCSg4YP+W/pBv8zRNcpM+ilUgA8bBZE7S3vmFMsKyPE
         ndZIK7NZLUkehEoz8SpGvEFYOFhmG2VBmFEFn24hyU6luXNdhz+eBHX8nDGNU5AbV9Gz
         UbSBSji/2976kUJZTX+qtdI3vslc8zN3OFh+jCgJilfmYaCu/exiMA6gxWklSqW/8N6V
         WqPw==
X-Gm-Message-State: AOPr4FXF6wGQJJCdvCO1kVdgeVDASMka04S1eTy5wmLKa7sK0VMH1MOQ4RE50QJzYTrI8D+hkjmberAiCWYd7w==
X-Received: by 10.159.37.68 with SMTP id 62mr19670657uaz.73.1461569748564;
 Mon, 25 Apr 2016 00:35:48 -0700 (PDT)
Received: by 10.176.5.2 with HTTP; Mon, 25 Apr 2016 00:35:48 -0700 (PDT)
In-Reply-To: <8340C6E5-C774-46EE-A1F9-1C4C7DF9CEB9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292454>

On Mon, Apr 25, 2016 at 9:33 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:

>> if you're omitting lines from the output. Also, the regex matches
>> against the whole multi-line string. That is, if the file for some
>> reason was ending in '\n\n' instead of just '\n', the '.*' would match
>> almost all content of the pointer file, not just the remains of the
>> preamble. One way to fix this would be to use
>>
>> re.sub(r'Git LFS pointer for [^\n]+\n\n', '', pointerFile)
>>
>> instead.
>
> In general you are right as "*" is greedy. However, in Python "." matches any
> character except a newline [1]. Therefore I think the regex is correct.

Ah, thanks for pointing that out. Looks ok to me then.

> Nevertheless... thanks for making me read the line again. I forgot to
> assign the pointerFile variable in the version I sent around :-(
>
> This is how it should be:
>
> pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)

Right. Good you've catched that!

-- 
Sebastian Schuberth
