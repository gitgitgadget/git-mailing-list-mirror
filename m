From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PULL REQUEST] initial pack v4 support
Date: Tue, 10 Sep 2013 18:31:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309101829330.20709@syhkavp.arg>
References: <alpine.LFD.2.03.1309091526430.20709@syhkavp.arg>
 <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Nguyn_Th=E1i_Ngc_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:31:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWTT-00076D-JW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab3IJWbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:31:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35796 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab3IJWbv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:31:51 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSX00A2QL92QPD0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Sep 2013 18:31:50 -0400 (EDT)
In-reply-to: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234496>

On Tue, 10 Sep 2013, Junio C Hamano wrote:

> >       packv4-parse.c: allow tree entry copying from a canonical tree object
> 
> This one needed a small fix-up to make it compile.
> 
> I do not particularly like reusing that "size" variable, but it
> seemed to be dead at that point, so...
> 
>  packv4-parse.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/packv4-parse.c b/packv4-parse.c
> index f96acc1..3f95ed4 100644
> --- a/packv4-parse.c
> +++ b/packv4-parse.c
> @@ -365,13 +365,14 @@ static int copy_canonical_tree_entries(struct packed_git *p, off_t offset,
>  		update_tree_entry(&desc);
>  	end = desc.buffer;
>  
> -	if (end - from > *sizep) {
> +	size = (const char *)end - (const char *)from;
> +	if (size > *sizep) {

BTW, a simpler fix might simply involve declaring those 2 variables as 
const char * up front which would remove the need for any cast.


Nicolas
