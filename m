From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 15 Apr 2016 07:07:09 +0700
Message-ID: <CACsJy8Dt8JDk5mkLkbc62w2kpKhBPxt5mcccs69wfpSH11sTug@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
 <xmqqy48ggmcs.fsf@gitster.mtv.corp.google.com> <1460653332.5540.84.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.co>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 02:07:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqrIY-0004c8-UZ
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 02:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbcDOAHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 20:07:43 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36655 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcDOAHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 20:07:42 -0400
Received: by mail-lf0-f43.google.com with SMTP id g184so127553201lfb.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FqflEoiIAScmJGJzeVM6imZ4dtdA29MgKlgzoX39qA0=;
        b=IBGif2VLu4mjtXIQAUMo0tmwdOAHi4B0aEfmTBM6oZ2RF3ALtFXAuz66TJtV00V+Ri
         ohIt3E5eZg7plZlJW1IrM4kXd8JDtAj20ee1JC2txQt9E4yzmdlI10ITTaykN3H8sD3M
         bZP2oS9Upn62n8pHeCxN3CTFm2RAg5U0sCkznYUSv2dbGH86iSie06ttTUIKQqQQ0ktu
         TQVqkSTECVZ0HJ6nnQH1/mDFvY9kV7xwpvqXF9C5Lmz0gitUhzpeHR4nTGLl8XEs8dVA
         HANtUilvyph1hksLMQ88LxUTuN331xFmVxPkCprwFTQc4G/5s/QE8/H50wUo/bTOCmmI
         5sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FqflEoiIAScmJGJzeVM6imZ4dtdA29MgKlgzoX39qA0=;
        b=fSb7vHugFkJ3ChyjuptTD0NIGgJMWnaqX2y+DqHXaAyuEASrkWbggvIx7Zi22FEXsG
         A6jIkoKL09e8FKaU0W0JoGJXk4r0pd2f9FTKgerINXQexvq0gsNnFVH5+c7iMqVWYiSv
         s2r0+ZhD/G1+Ul2uFdGOuQLG0XCtCYff6AWYmhjeDnk7UjzSb9IXdvZq4gzawdiyW2sm
         lYcJV1AraKMu10XmwEtJIeo0hYnHHMHCu7vBXyHw4EV6QgJ6Im4EElgJheGAuEC+JRyc
         WJLQ8U9ftEwhA55VNpKFW+P+wynnvwF/gKbdRWIgEEnzRThyZF4HB0hO80ZPUVJPsdB3
         wQUw==
X-Gm-Message-State: AOPr4FVhcZjjD9+cSLzIbJWLt6DQlLhcuzzHbvy1Z+I/13avkTn7TSQHapL9FcOh4JN2Z1Rair5W/1x4s3cSJg==
X-Received: by 10.25.211.75 with SMTP id k72mr7353954lfg.45.1460678859811;
 Thu, 14 Apr 2016 17:07:39 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 14 Apr 2016 17:07:09 -0700 (PDT)
In-Reply-To: <1460653332.5540.84.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291580>

On Fri, Apr 15, 2016 at 12:02 AM, David Turner <dturner@twopensource.com> wrote:
>> > On webkit.git with index format v2, duplicating 8 times to 1.4m
>> > entries and 200MB in size:
>> >
>> > (vanilla)      0.986986364 s: read_index_from .git/index
>> > (index-helper) 0.267850279 s: read_index_from .git/index
>> >
>> > Interestingly with index v4, we get less out of index-helper. It
>> > makes
>> > sense as v4 requires more processing after loading the index:
>> >
>> > (vanilla)      0.722496666 s: read_index_from .git/index
>> > (index-helper) 0.302741500 s: read_index_from .git/index
>> >
>> > (these benchmarks are from an earlier version of this patch, but
>> > should
>> > still be valid).
>>
>> Just something to keep in mind; we'd need to see updated numbers
>> when the series matures.
>
> I don't actually know how Duy did the index duplication for this
> benchmark.  Duy?

Start with webkit.git (which was one of the biggest worktree i found),
then put the entire directory structure in a subdirectory e.g.

git ls-files --stage | sed 's/\t/\tsubdir1\//' | git update-index
--add --index-info --stdin

repeat until you get to a reasonable size.
-- 
Duy
