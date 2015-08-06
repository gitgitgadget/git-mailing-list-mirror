From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Error when cloning with weird local directory
Date: Thu, 06 Aug 2015 00:50:21 -0700
Message-ID: <xmqqpp30zwhu.fsf@gitster.dls.corp.google.com>
References: <CAFOYHZByteuPZwRvw9tzFWOD6vguw4wPK1J6rLZZvHzyZRBtSA@mail.gmail.com>
	<55C2F54A.7070702@web.de>
	<xmqqtwsczws6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 09:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNFwa-00028T-4Y
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 09:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbbHFHuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2015 03:50:24 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34519 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbbHFHuX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 03:50:23 -0400
Received: by pdber20 with SMTP id er20so29076456pdb.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=vevkNzxCrMZTjocE/lp9mB359ggvzUvTmpC3vKv4oxA=;
        b=fnP0pONXpQPwgN7iC1YPQNeZ6N9HIwnYHjpPEMyIjkvvHlHRijxnFja4VarvOFkBxF
         Nd7laNPIBavor6THTIq0i7LBkDs2kEd+y3Y60XuWOAsCob2aWCqoIZN0aovIeEYYbiVh
         UL/BXiUDG/liakoSpAgP4rpv4evHB2FYcweetEhxjiTnN50vzdarkWfOFuYggjqKiHl+
         29QnO0ODo+OrmKNK770+66EJL7C0leX4z33W4XdL/CppCz7YdmRHrICSv1PBq3OU0Zgq
         mjyWSj6tjlaN269Qu3tIM4L1DYgQuRiZXKSq6dtc4l3vYawNE5l+ARZuD51vPNNX3mE8
         1xmg==
X-Received: by 10.70.123.226 with SMTP id md2mr662340pdb.29.1438847423159;
        Thu, 06 Aug 2015 00:50:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id oq10sm5434136pdb.75.2015.08.06.00.50.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 00:50:22 -0700 (PDT)
In-Reply-To: <xmqqtwsczws6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 06 Aug 2015 00:44:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275419>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> It looks as if
>> static char *get_repo_path(const char *repo, int *is_bundle)
>> in built/clone.c
>> checks if there is a local directory structure looking like a
>> .git directory.
>> This is wrong.
>
> It is as designed, though, to allow cloning from a local directory
> with any name.
>
>> There should be a check for the scheme first.
>
> That will be wrong.

It matters mostly when dealing with scp-like syntax, word:path.

I _think_ taking notice of "word://" (with doubled slashes) and
treating it specially will not introduce any new issue; while it is
still OK for users to have a local directory called "word:", if they
meant a subdirectory of it, they wouldn't have typed double-slashes
there.
