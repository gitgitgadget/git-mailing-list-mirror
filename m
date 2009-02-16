From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: CVS import [SOLVED]
Date: Mon, 16 Feb 2009 18:33:44 +0100
Message-ID: <4999A378.2040905@pelagic.nl>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl> <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902161443230.6289@intel-tinevez-2-302> <alpine.DEB.1.00.0902161451210.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 18:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7NC-00072p-TP
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbZBPRdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbZBPRdq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:33:46 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:58611 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751056AbZBPRdp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 12:33:45 -0500
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 90C5C58BD88;
	Mon, 16 Feb 2009 18:33:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902161451210.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110215>

Johannes Schindelin wrote:
> Hi,
>
> On Mon, 16 Feb 2009, Johannes Schindelin wrote:
>
>   
>> On Mon, 16 Feb 2009, Ferry Huberts (Pelagic) wrote:
>>
>>     
>>> I solved it:
>>>
>>> it has to do with the
>>> core.autocrlf=input
>>> core.safecrlf=true
>>>
>>> settings I had in my global config.
>>>       
>> Thanks!
>>
>>     
>>> Maybe the manual page should warn against having these defined?
>>>       
>> Maybe it should be solved differently?  As cvsimport needs to operate with 
>> autocrlf=false, it seems, it could set that variable when it creates a 
>> repository, and check the variable otherwise (erroring out if it is set 
>> inappropriately)?
>>     
>
> IOW something like this:
>
> -- snip --
>  git-cvsimport.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index e439202..a27cc94 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -562,12 +562,16 @@ my %index; # holds filenames of one index per branch
>  unless (-d $git_dir) {
>  	system("git-init");
>  	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
> +	system("git-config core.autocrlf false");
> +	die "Cannot set core.autocrlf false" if $?;
>  	system("git-read-tree");
>  	die "Cannot init an empty tree: $?\n" if $?;
>  
>  	$last_branch = $opt_o;
>  	$orig_branch = "";
>  } else {
> +	die "Cannot operate with core.autocrlf other than 'false'"
> +		if (`git-config --bool core.autocrlf` =~ /true|input/);
>  	open(F, "git-symbolic-ref HEAD |") or
>  		die "Cannot run git-symbolic-ref: $!\n";
>  	chomp ($last_branch = <F>);
> -- snap --
>
> If you could add a test to t9600 and a few words to the man page, that 
> would be awesome.
>
> Ciao,
> Dscho
>
> P.S.: I think the same strategy should be applied to git-svn...
>   
I'm willing to give it a stab but I'm not versed on Perl at all. C and 
Java I can do without breaking a sweat though.
Isn't it a better idea to have the original authors do this? They 
understand the code.
Also, doing this would constitute my first patch to git. I'm unfamiliar 
with its codebase and the requirements of the people that contribute to 
it. Willing to learn though :-)
My patches would then probably need some review and would take a bit 
longer to develop. If that's acceptable then I'm willing to try.

Ferry
