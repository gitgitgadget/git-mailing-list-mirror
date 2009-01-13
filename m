From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Simplest update to bash completions to prevent unbounded
 variable errors
Date: Tue, 13 Jan 2009 10:30:56 -0500
Message-ID: <496CB3B0.7010605@tedpavlic.com>
References: <496C1F5F.9020604@tedpavlic.com> <20090113152047.GO10179@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 16:32:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMlFg-0006Nv-1E
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 16:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbZAMPa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 10:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbZAMPa7
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 10:30:59 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:58989 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750770AbZAMPa6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2009 10:30:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id BF04580D8038;
	Tue, 13 Jan 2009 10:25:14 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Eviy1zun7iR; Tue, 13 Jan 2009 10:25:14 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A6CBE80D8031;
	Tue, 13 Jan 2009 10:25:14 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <20090113152047.GO10179@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105501>

>> Another try at fixing bash completions in "set -u" environments.
> I agree with Junio; setting -u in your interactive shell is as bad
> as export CDPATH.  Its crazy.

This whole series of patches was inspired by a group of workstations at 
a university that set -u by default for all users.

Additionally, doesn't "set -u" make tcsh users feel more at home in 
bash? Certainly other shells have this same behavior in their 
interactive modes.

>> Additionally added some comments and omitted things like Vim modelines.
>
> These are orthogonal to the -u corrections.  They should be in a
> different patch.  The comments are wecome.  The '#!bash' looks like
> a good idea.  But a vim specific modeline, I don't like, for the
> reasons Junio has already stated.

OK. Can do.

>> -	if [ -z "$1" ]; then
>> +	if [ $# -eq 0 ] || [ -z "$1" ]; then
>
> This is one of those places where [ -z "${1-}" ] is likely easier

That was a mistake. I missed that hunk. I meant to use the ${1-}.

>> +		if [ $# -gt 0 ]&&  [ -n "$1" ]; then
>
> Eh, I'd rather see [ -n "${1-}" ] over the&&  test.

Again, my mistake. It was late and I missed it.


>> +complete -o bashdefault -o default -o nospace -F _git git 2>/dev/null \
>> +	|| complete -o default -o nospace -F _git git
>> +complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
>> +	|| complete -o default -o nospace -F _gitk gitk
>
> Why are we switching to bashdefault?  Is this an unrelated change
> from the -u stuff and should go into its own commit, with its own
> justification?

Ok.

 From what I understand, normal bash completion is like setting "-o 
bashdefault -o default". That is, it tries the bash completions first 
before going to the filename completion. This change makes it so that 
git jumps back to bash completion if nothing git-specific is found. If 
nothing bash-specific is found, it will go back to standard default 
filename completion.

--Ted



-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
