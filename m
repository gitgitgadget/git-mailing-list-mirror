From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Experimental "git prune"
Date: Wed, 5 Jul 2006 09:24:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607050923360.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0607041539550.12404@g5.osdl.org>
 <Pine.LNX.4.63.0607050956240.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 05 18:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyABU-00062H-8n
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 18:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWGEQZA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 12:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWGEQZA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 12:25:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964856AbWGEQY7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 12:24:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k65GOmnW030474
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 5 Jul 2006 09:24:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k65GOka8018665;
	Wed, 5 Jul 2006 09:24:47 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607050956240.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23352>



On Wed, 5 Jul 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 4 Jul 2006, Linus Torvalds wrote:
> 
> > static void process_tag(struct tag *tag, struct object_array *p, const char *name)
> > {
> > 	struct object *obj = &tag->object;
> > 	struct name_path me;
> 
> AFAICS this variable is set, but not used:
> 
> > 
> > 	if (obj->flags & SEEN)
> > 		return;
> > 	obj->flags |= SEEN;
> > 
> > 	me.up = NULL;
> > 	me.elem = "tag:/";
> > 	me.elem_len = 5;
> > 
> > 	if (parse_tag(tag) < 0)
> > 		die("bad tag object %s", sha1_to_hex(obj->sha1));
> > 	add_object(tag->tagged, p, NULL, name);

Yeah, that NULL should be "&me".

That said, we don't actually use the object name logic at all, so we could 
drop it entirely. Having it _might_ allow some of the error messages to be 
better, who knows..

			Linus
