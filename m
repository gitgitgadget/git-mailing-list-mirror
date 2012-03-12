From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 21:20:07 +0100
Message-ID: <4F5E5A77.1070605@lyx.org>
References: <4F5E4B20.5080709@lyx.org> <7vobs1r3kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:20:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Bj7-0004UK-9H
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131Ab2CLUUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:20:10 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64656 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757096Ab2CLUUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:20:09 -0400
Received: by eaaq12 with SMTP id q12so1451711eaa.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 13:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=V0CphRTQTo2Mp66dYo/H6s7bwkpluBolYbR93lNNamE=;
        b=RjKK4y9w9li2RuIANmYgGPIvIJSikKu5yKsHKbCRrsIjuCd22Wray4p1IWldO4nY01
         L0HeiiQGi+Im79Xv8ei0eHUKlqMNELwfyDMtWdhqwHlxkkvYY+MD/mX1rGqG2EgUR1eR
         z4ral0j45EAUr9Bbkj3jmjWbblGxmoe9wCOmc9xxPQIQdyNpAtl+L8zuJgYGSoieIzbp
         hBx8npOQEi7lYcPSIOGZ4HM+fiALzbKlyliq9Hgiy2x4uyjp8XAlSQZ6ZoQ70XB/ZRZ0
         DFqxz7h6Qxdn3oTzFULgRPSquEXFbZp5bg2CStl+ZTzTuLtagtqSCM6eUJq0UsxFholJ
         rWjA==
Received: by 10.213.19.19 with SMTP id y19mr1016989eba.264.1331583607929;
        Mon, 12 Mar 2012 13:20:07 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id p57sm38126014eei.8.2012.03.12.13.20.07
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 13:20:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vobs1r3kn.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkS86xRxY+XQQ0OW+a1/jfleI8lAF1x/hhZUm1aUXtY+6yh8qEsEnnurt0oN51385vsbsyd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192940>

Op 12-3-2012 21:01, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>> Would it be a useful addition to have a command 'git rerere edit
>> <path>  <commit>' ?
>>
>> This would allow the user to edit the conflict resolution which was
>> used in a certain commit (merge, rebase.. ).
>>
>> Now I tend to grep in the .git/rr-cache directory, because I don't
>> want to do 'git rerere forget' as this would require me to refix more
>> resolution than needed.
> I haven't find it necessary in practice, as the re-fix for me
> typically would go like this:
>
>      $ git merge other-branch
>      ... rerere kicks in; eyeball the results
>      ... ah, my earlier resolution is no longer correct
>      $ edit $the_path
>      ... test the result of manual edit in the context of the merged whole
>      ... and be satisified
>      $ git rerere forget $the_path
>      $ git add $the_path
>      $ git commit
>      ... rerere records the updated resolution
>
> What scenario do you have in mind that you would need to re-fix more
> resolution than you need?

Context:
I have a number of topic branches that modify the fileformat version and 
also the fileformat conversion routines. When merging all those branches 
into an integration branch (like you regenerate pu), there are a lot of 
annoying merge conflicts in these two files. From one of your scripts I 
took some code to automatically commit the merge resolution (here I go 
wrong, I probably neglected the reason that git doesn't allow to 
autocommit (yet)).

I can of course disable the autocommit, run the merge sequence again, 
commit the correct merge resolutions, and modify the merge resolution 
that went wrong.

But somehow I felt I was missing the 'git rerere edit' command. Aren't 
the recorded merge resolutions essentially part of the codebase, though 
in practice they remain rather anonymous temporary thingies.

But well, if the experts don't feel the need, I will search further to 
implement something that you do think is useful ;).

Vincent
