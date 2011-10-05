From: Gioele Barabucci <gioele@svario.it>
Subject: Re: Git attributes ignored for root directory
Date: Wed, 05 Oct 2011 19:56:05 +0200
Message-ID: <4E8C9A35.5030504@svario.it>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu> <7vd3eb8hkb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 19:56:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBVhX-0007G7-6l
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 19:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056Ab1JER4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 13:56:11 -0400
Received: from begonia.svario.it ([91.213.195.127]:46958 "EHLO
	begonia.svario.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab1JER4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 13:56:10 -0400
Received: from [192.168.2.2] (dynamic-adsl-84-223-204-232.clienti.tiscali.it [84.223.204.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: gioele@svario.it)
	by begonia.svario.it (Postfix) with ESMTPSA id BD3A02CE35;
	Wed,  5 Oct 2011 17:56:06 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110923 Thunderbird/7.0
In-Reply-To: <7vd3eb8hkb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182871>

On 05/10/2011 19:38, Junio C Hamano wrote:
>> In fact the support for gitattributes using patterns involving "." was
>> pretty spotty in v1.7.6 too.  For example,
>
> The attribute patterns (or exclude patterns for that matter) were never
> designed to name "the current directory". The way to name "everything *in*
> this directory" has always been to say "*" (the "* text=auto" example in
> the documentation says it shows how to set the attribute "for all
> files"). Admittedly the pattern may miss ".*" files.

What if I do not want to say things about the "content" of the directory 
but about the directory itself? This is exactly my case.


> I have to agree that things like "./" and "."  were outside the scope of
> the design; in some cases undefined behaviour given to such patterns may
> have made sense but that was mere accident.

Actually what I have in my `~/.gitattributes` is

     /. show_in_prompt=no

Anyway, I see a conflict between

>   - A leading slash matches the beginning of the pathname.
>     For example, "/{asterisk}.c" matches "cat-file.c" but not
>     "mozilla-sha1/sha1.c".

and

>   - If the pattern is a single dot and nothing else, it matches everything
>     in the current directory.

in the first case `.` is treated as a "glob dot", while in the second 
case it is treated as a "regexp dot". I would find this confusing.

Patterns can match directories using `/foo`. Why don't you just say that 
`.` is equivalent to `./` and `/foo/.` is equivalent to `/foo`?


> So "./" in .gitignore or .gitattributes at the toplevel would match all
> the top-level directories and files but does not apply to the paths
> contained in the matched directories. "." in .gitignore or .gitattributes
> at the toplevel would match everything under the sun.

In the case of `.gitignore`, `/foo/.` and `/foo/` would have the same 
effect and they look sane to me.


> Would it be sensible to assume that users would not be surprised if
> ". text=auto" meant that the attribute applies to every file in the
> worktree?

I would be surprised as I expect `.` to be a "glob dot". But maybe it is 
just me and my prejudices :)

Bye,

-- 
Gioele Barabucci <gioele@svario.it>
