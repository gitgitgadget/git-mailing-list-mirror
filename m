From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Do not generate full commit log message if it not
	going to be used
Date: Tue, 27 Nov 2007 22:47:13 +0100
Message-ID: <20071127214713.GB3156@steel.home>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com> <474C0105.3010908@viscovery.net> <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com> <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org> <81b0412b0711271018m6419b076n269a0175494fac84@mail.gmail.com> <20071127214425.GA3156@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 22:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix8HJ-0007gF-Ow
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 22:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757713AbXK0VrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 16:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757624AbXK0VrS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 16:47:18 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:30618 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348AbXK0VrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 16:47:17 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg79ik=
Received: from tigra.home (Fcbf4.f.strato-dslnet.de [195.4.203.244])
	by post.webmailer.de (fruni mo60) (RZmta 14.3)
	with ESMTP id x003a0jARJtang ; Tue, 27 Nov 2007 22:47:13 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5A38D277AE;
	Tue, 27 Nov 2007 22:47:13 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3B8A456D22; Tue, 27 Nov 2007 22:47:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071127214425.GA3156@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66265>

Alex Riesen, Tue, Nov 27, 2007 22:44:25 +0100:
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -367,6 +367,30 @@ static int prepare_log_message(const char *index_file, const char *prefix)
>  
>  	strbuf_release(&sb);
>  
> +	if (no_edit) {
> +		static const char *argv[] = { NULL, "HEAD", NULL };
> +		struct rev_info rev;
> +		unsigned char sha1[40];
> +		int is_initial;

is_initial is left over from "development process". Well, from
stealing out of wt-status.c
