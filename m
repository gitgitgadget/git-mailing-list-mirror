From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: accept indented comments (fixes regression)
Date: Wed, 30 Sep 2015 13:34:02 -0700
Message-ID: <xmqq8u7n7ikl.fsf@gitster.mtv.corp.google.com>
References: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqd1wz9402.fsf@gitster.mtv.corp.google.com>
	<xmqqy4fn7m2s.fsf@gitster.mtv.corp.google.com>
	<vpqh9mbhek2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 30 22:34:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhO4p-0000XQ-7w
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 22:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbbI3UeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 16:34:06 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36405 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932775AbbI3UeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 16:34:04 -0400
Received: by pablk4 with SMTP id lk4so49926425pab.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hOp75BBi0aiGwfVVS1EuSVEWP3sD+SJLVUspbwWgE4g=;
        b=1IG8rcC/iQ6KHu8xurWbIJsbClcV4zRGRrYmUbJLDF+E5Dsooa0MFIck1JIZsKihmL
         OyeFdLK6/N+2h7PuZOHrOmFgQhlm0y46hq1UXufwznSxGG0+jXP95uJoqanlM87iI7j7
         IunU87ucH7lwzl43PrrUNXAIcMNVrhheKd8B2RRBPTEBiaXYRbTTc3b7/IHes4plPtp+
         VheUGKAMYQNz74rWY2hL5/Sz6r9j3xVCKPyfOQ8Weq0Xrg1MojdwLE7znh1MM42ZooqE
         lncdO2D4B2I/QB0FgYz0JmoZ7mrpqewLVGKlysVaUtaiSsgGsGZ6WrD7t7B7gDfToaKV
         9mag==
X-Received: by 10.68.93.133 with SMTP id cu5mr7207073pbb.71.1443645243707;
        Wed, 30 Sep 2015 13:34:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id eu2sm2334689pbc.48.2015.09.30.13.34.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 13:34:03 -0700 (PDT)
In-Reply-To: <vpqh9mbhek2.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 30 Sep 2015 21:50:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278869>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
>> +			if ! check_commit_sha "${rest%% *}" "$lineno" "$1"
>
> This does not pass my "tabs" test, as it parses the sha1 out of the line
> assuming it's separated with a space.

Yes, it was very much deliberate to match what transform_todo_ids does.

I do not think we mind loosening this SP to SP/HT at all, but if we
are going to go in that direction, I'd very much more prefer to do

	"${rest%%[     ]*}"

here _and_ in transform_todo_ids so that we can keep the identical
parsing, which is the primary point of the "regression fix", rather
than doing this:

> I changed it to
>
> 	while read -r command sha1 rest
>
> which is a bit more lazy.

which is to invite the two parsers drift apart over time.

Thanks.
