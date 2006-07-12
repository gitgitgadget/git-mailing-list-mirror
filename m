From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 21:31:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607112128270.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
 <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607120226210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607111755180.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, sf <sf-gmane@stephan-feder.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 06:31:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0WNo-00076y-KV
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 06:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWGLEba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 00:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWGLEba
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 00:31:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932415AbWGLEb3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 00:31:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6C4VLnW018312
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 21:31:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6C4VK62024007;
	Tue, 11 Jul 2006 21:31:21 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0607111755180.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23760>



On Tue, 11 Jul 2006, Linus Torvalds wrote:
> 
> Junio: this patch is totally independent from the other patches, and is on 
> top of you current "master". It gets rid of TYPE_xxx in favor of the 
> OBJ_xxx enums, which are moved from pack.h into object.h.
...
>  static inline const char *typename(unsigned int type)
>  {
> -	return type_names[type > TYPE_TAG ? TYPE_BAD : type];
> +	return type_names[type > OBJ_TAG ? OBJ_BAD : type];

That should be "[type > OBJ_BAD ? OBJ_BAD : type]"

Not that any users will care, because the current users of the typename() 
macro are the old TYPE_xxxx users which will never see the OBJ_DELTA case 
anyway. So it's not a big deal, but let's do it right for future users (ie 
if the pack-file things want to start using "typename(type)" and they 
actually _have_ delta descriptors).

		Linus
