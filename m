From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Edit a rerere conflict resolution
Date: Fri, 16 Mar 2012 16:54:15 +0100
Message-ID: <4F636227.2060102@lyx.org>
References: <4F5E4B20.5080709@lyx.org> <7vobs1r3kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 16:54:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ZU3-0001wR-To
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 16:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423056Ab2CPPyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 11:54:20 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36303 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965332Ab2CPPyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 11:54:19 -0400
Received: by eekc41 with SMTP id c41so2202461eek.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 08:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=zaB/1Y7yL7h/3KJW7OnmPBXz9Z4oa+V5vYc+pcIGk3c=;
        b=h+n6YLD8bYV37dG3VarOecjKESj+jAwldhs15N0PxuE0RpEHRloBikNesYJay66/QH
         95zkwIEyRBaOTzcrKnA9U5FYcZ8UrSTntODWlEcmb+v+YGlYx7Dptmro/8vlhyDYU6dK
         P3+Q68iCSqQmG6uDJUNQ0d/OVn+3kz/p7pUmAD+shQjLzQSU/EZz639i0lvrS/2I5W+6
         bDcMq8pesCuGyd0ceCiC4zBPbedMN3VCSPZfmj8DTKGsHKsPWf80SVRpd/b33mKaFxcZ
         zBWRvAeSOi9muW+pzjl3a4E4rG3eicGBPLeXJmmwUm9U0tLQaSsqPe9ytEAcbvBT0oVs
         /yVg==
Received: by 10.213.4.131 with SMTP id 3mr194202ebr.22.1331913257983;
        Fri, 16 Mar 2012 08:54:17 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id n55sm19798549eef.6.2012.03.16.08.54.17
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 08:54:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vobs1r3kn.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQn0BlymPsQbIKMzhxIFQWKMBd0dzzCkZe20n1RqfoE0hflUg7PZL0axa/fgK0fbnZ5r3rYU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193271>

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
This doesn't really work for me:

      $ git merge other-branch
      Auto-merging <path>
      CONFLICT (content): Merge conflicts in <path>
      Resolved '<path>' using previous resolution.
      Automatic merge failed; fix conflicts and then commit the result.

      $ git rerere status
      $ git rerere forget <path>
      error: no remembered resolution for <path>

      $ edit <path>
      $ git commit -a -m "fix"
      ... no sign of rerere doing something.

Why is this different from what you describe above, and how can I modify 
the recorded resolution ?

Vincent
