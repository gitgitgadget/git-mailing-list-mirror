From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Fri, 06 Sep 2013 09:19:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309060916400.20709@syhkavp.arg>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg>
 <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
 <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
 <alpine.LFD.2.03.1309042350560.14472@syhkavp.arg>
 <CACsJy8BeU_01c0f5RJExcYo7xGETnduKOw-_shszHd0ZFgZDXw@mail.gmail.com>
 <alpine.LFD.2.03.1309050024090.14472@syhkavp.arg>
 <CACsJy8CX=4Oz_h2NtS3FRdK6_zdFksa+JR5C6Z-z3Y70PLAsyQ@mail.gmail.com>
 <alpine.LFD.2.03.1309050131000.14472@syhkavp.arg>
 <CACsJy8DKL9KnPAXcf+NPU_Y5J1Dz_pYxSpONN4LxcQVi1JOBYw@mail.gmail.com>
 <CACsJy8BbxKfX_Ho8Nu2fvTp1xWYcaGPgwf6=iq0bZ4KSE+r6bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 15:19:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHvwT-0001BW-1U
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 15:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab3IFNTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 09:19:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11904 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab3IFNTM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 09:19:12 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSP001EFGZZYP50@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Sep 2013 09:19:11 -0400 (EDT)
In-reply-to: <CACsJy8BbxKfX_Ho8Nu2fvTp1xWYcaGPgwf6=iq0bZ4KSE+r6bw@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234047>

On Fri, 6 Sep 2013, Duy Nguyen wrote:

> On Thu, Sep 5, 2013 at 11:52 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Sep 5, 2013 at 12:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> Now the pack index v3 probably needs to be improved a little, again to
> >> accommodate completion of thin packs.  Given that the main SHA1 table is
> >> now in the main pack file, it should be possible to still carry a small
> >> SHA1 table in the index file that corresponds to the appended objects
> >> only. This means that a SHA1 search will have to first use the main SHA1
> >> table in the pack file as it is done now, and if not found then use the
> >> SHA1 table in the index file if it exists.  And of course
> >> nth_packed_object_sha1() will have to be adjusted accordingly.
> >
> > What if the sender prepares the sha-1 table to contain missing objects
> > in advance? The sender should know what base objects are missing. Then
> > we only need to append objects at the receiving end and verify that
> > all new objects are also present in the sha-1 table.
> 
> One minor detail to sort out: the size of sha-1 table. Previously it's
> the number of objects in the pack. Now it's not true because the table
> may have more entries. So how should we record the table size? We
> could use null sha-1 as the end of table marker. Or we could make
> pack-objects to write nr_objects as the number of entries _after_ pack
> completion, not the true number of objects in thin pack. I like the
> latter (no more rehashing the entire pack after completion) but then
> we need a cue to know that we have reached the end of the pack..

See the amendment I made to your documentation patch.  I opted for the 
later.  To mark the end of the transmitted objects a zero byte (object 
type 0) is used.


Nicolas
