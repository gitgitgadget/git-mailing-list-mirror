From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 19/21] index-pack,
 pack-objects: allow creating .idx v2 with .pack v4
Date: Wed, 11 Sep 2013 11:48:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309111136380.20709@syhkavp.arg>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
 <1378879582-15372-20-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_ZRLx0mMrzlfPt/D+XCMqrA)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 17:48:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJmeO-0008Mg-5q
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 17:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124Ab3IKPsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 11:48:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54495 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab3IKPsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 11:48:11 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSY00465X83TKD0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Sep 2013 11:48:03 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 5B9092DA0625; Wed, 11 Sep 2013 11:48:03 -0400 (EDT)
In-reply-to: <1378879582-15372-20-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234569>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_ZRLx0mMrzlfPt/D+XCMqrA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 11 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> While .idx v3 is recommended because it's smaller, there is no reason
> why .idx v2 can't use with .pack v4. Enable it, at least for the test
> suite as some tests need to this kind of information from show-index
> and show-index does not support .idx v3.

FYI, I've added that ability to show-index in my tree.  The output does 
not include the actual object SHA1 though.

[...]
> @@ -2167,6 +2170,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  
>  	curr_pack = open_pack_file(pack_name);
>  	parse_pack_header();
> +	if (!packv4 && opts.version >= 3)
> +		die(_("pack idx version %d does not work with pack version %d"),
> +		    opts.version, 4);

I don't think this is what you really meant here.  I've amended this 
patch with:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4607dc6..f071ed9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2171,8 +2171,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
 	if (!packv4 && opts.version >= 3)
-		die(_("pack idx version %d does not work with pack version %d"),
-		    opts.version, 4);
+		die(_("pack idx version %d requires at least pack version 4"),
+		    opts.version);
 	objects = xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_dictionaries();


Nicolas

--Boundary_(ID_ZRLx0mMrzlfPt/D+XCMqrA)--
