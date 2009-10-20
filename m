From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git gc and kernel.org
Date: Tue, 20 Oct 2009 17:16:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910201706430.21460@xanadu.home>
References: <4ADD6026.8070203@zytor.com>
 <7veioyqzeo.fsf@alter.siamese.dyndns.org>
 <200910201054.48315.johan@herland.net>
 <alpine.LFD.2.00.0910201442480.21460@xanadu.home>
 <7v63a9n5i6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:16:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0M4O-0003p7-Tn
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 23:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbZJTVQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 17:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbZJTVQb
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 17:16:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45130 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbZJTVQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 17:16:30 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRU00MH40FMS4K0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Oct 2009 17:16:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v63a9n5i6.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130850>

On Tue, 20 Oct 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Still... Hopefully this is going to become redundant information in the 
> > future with the eventual deployment of smart protocol over HTTP.  So I 
> > think that as a config option being off by default this is a good 
> > compromize.  Site administrators can turn it on by default in 
> > /etc/gitconfig.
> 
> Ok, something like this?

Looks fine to me, except...

> +receive.autogc::
> +	If set to true, git-receive-pack will run "git-gc --auto"
> +	after receiving data from git-push and updating refs.

While I was arguing for automatic git-update-server-info to be off by 
default, I however think that this one might be worth turning on by 
default.  Most of the time I expect people simply don't log into the 
server where they push stuff and the kernel.org episode certainly shows 
this as being a worthwhile thing to do, and contrary to 
update-server-info this is likely to always be so even in the future.

> @@ -672,6 +684,12 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  			report(unpack_status);
>  		run_receive_hook(post_receive_hook);
>  		run_update_post_hook(commands);
> +		if (auto_update_server_info)
> +			update_server_info(0);
> +		if (auto_gc) {
> +			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
> +			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> +		}

If git-update-server-info is listing packs, shouldn't it be run after 
git-gc and not before?


Nicolas
