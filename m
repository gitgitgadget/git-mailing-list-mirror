From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 08/11] pack-objects: create pack v4 tables
Date: Mon, 09 Sep 2013 09:07:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309090900210.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378652660-6731-9-git-send-email-pclouds@gmail.com>
 <CACsJy8DbMnr9Y8NyGTNd6r8hSg3zbgaLa1h-e1X7FFVHHahwpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_MdvbNK4wzuOIbbDQ4WcfKQ)"
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1BV-0000ck-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab3IINHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 09:07:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab3IINHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:07:09 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSV00KIV0FWV880@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Sep 2013 09:07:08 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 6BF982DA0625; Mon, 09 Sep 2013 09:07:08 -0400 (EDT)
In-reply-to: <CACsJy8DbMnr9Y8NyGTNd6r8hSg3zbgaLa1h-e1X7FFVHHahwpg@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234323>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_MdvbNK4wzuOIbbDQ4WcfKQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Mon, 9 Sep 2013, Duy Nguyen wrote:

> On Sun, Sep 8, 2013 at 10:04 PM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > +static void prepare_sha1_table(void)
> > +{
> > +       unsigned i;
> > +       /*
> > +        * This table includes SHA-1s that may not be present in the
> > +        * pack. One of the use of such SHA-1 is for completing thin
> > +        * packs, where index-pack does not need to add SHA-1 to the
> > +        * table at completion time.
> > +        */
> > +       v4.all_objs = xmalloc(nr_objects * sizeof(*v4.all_objs));
> > +       v4.all_objs_nr = nr_objects;
> > +       for (i = 0; i < nr_objects; i++)
> > +               v4.all_objs[i] = objects[i].idx;
> > +       qsort(v4.all_objs, nr_objects, sizeof(*v4.all_objs),
> > +             sha1_idx_sort);
> > +}
> > +
> 
> fwiw this is wrong. Even in the non-thin pack case, pack-objects could
> write multiple packs to disk and we need different sha-1 table for
> each one. The situation is worse for thin pack because not all
> preferred_base entries end up a real dependency in the final pack. I'm
> working on it..

Is anyone still using --max-pack-size ?

I'm wondering if producing multiple packs from pack-objects is really 
useful these days.  If I remember correctly, this was created to allow 
the archiving of large packs onto CDROMs or the like.

I'd be tempted to simply ignore this facility and get rid of its 
complexity if no one uses it.  Or assume that split packs will have 
inter dependencies.  Or they will be pack v2 only.


Nicolas

--Boundary_(ID_MdvbNK4wzuOIbbDQ4WcfKQ)--
