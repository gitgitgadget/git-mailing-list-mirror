From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 10:38:13 -0700
Message-ID: <xmqq7fqrzo1m.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 19:38:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8B6S-0005kB-VU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 19:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbbFYRiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 13:38:17 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35960 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbFYRiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 13:38:15 -0400
Received: by igbiq7 with SMTP id iq7so123965008igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=x+AwkTVaqLEhi1uOYe0V0Swm8L7fm+D5h7VXEDjKO0c=;
        b=NmztKG4L+IHgsuVE1fXXhWmk2nF50Cb4GiZw45w6xNsOVlUnqXAkB6f1a1AQTsa1rD
         lzpvfbaJcMa+XQmp55AWE1l88bsTuGMi1G3etAxGnRi7D6rPnAoGidoV+kc1fqWDvh0D
         hW3Fyddfpbsku1cVXwY+0/2tkqDRBjwe0fPBSvA2tJdQTHmGsjyhzFL6u5kR53Ol1253
         vr4Oq8GRIa9Mcw9COQ8g+etnO5TugUxnEkjDvnpAeVS/BAwcVYUAszyq+ws5TDEezTVb
         AutSePLiqXTm06TZPQ7tyrfqOdcDZxV0s5AtjjaP6aAIvQVJbVzfz5i3rHanqHw6R7+p
         r+Zw==
X-Received: by 10.50.136.197 with SMTP id qc5mr5573240igb.6.1435253895396;
        Thu, 25 Jun 2015 10:38:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id h128sm20015280ioh.38.2015.06.25.10.38.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 10:38:14 -0700 (PDT)
In-Reply-To: <20150625155128.C3E9738005C@gemini.denx.de> (Wolfgang Denk's
	message of "Thu, 25 Jun 2015 17:51:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272704>

Wolfgang Denk <wd@denx.de> writes:

> Apparently for some reason the tags  LABEL_2006_03_12_0025,
> LABEL_2006_04_18_1106, and LABEL_2006_05_19_1133 are missing newlines,
> which was undetected so far, but now is raised as an error.
>
> Question is: how can we fix that?
>
> Is there a tool to "auto-repair" such kind of errors?
>
> If not, would it be be a harmless thing to just delete and recreate
> the same tags (referring to the same commits)?  Or can anybody see any
> problems tha might be caused by such a tag re-creation?  I mean, it is
> not like a rebase of the repository or something like that?  Right?

I am inclined to say that these messages are that recent Git barking
at a non-errors, and hopefully there is nothing other than ignoring
them you have to do until it gets fixed.

But if you decide to recreate tags, there are a few things to keep
in mind:

 * You would get a different object name, of course.  You would
   likely to get different timestamps (you can export the desired
   timestamp in GIT_COMMITTER_DATE, though).

 * Those who fetched from you and already have these tags will not
   get the updated one by default.  They need to force fetch them.
