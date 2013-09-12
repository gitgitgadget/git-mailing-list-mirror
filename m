From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table
 size
Date: Thu, 12 Sep 2013 11:34:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309121132050.20709@syhkavp.arg>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-16-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
 <CACsJy8D=72RsnNKs-6EdUnhu6kurvQ5S2z5PkV3KcY7SUDHJKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 17:35:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK8ub-0005UL-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 17:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab3ILPeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 11:34:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57652 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab3ILPeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 11:34:25 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MT000DOMR9CEC10@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Sep 2013 11:34:24 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 13A5C2DA0625; Thu, 12 Sep 2013 11:34:24 -0400 (EDT)
In-reply-to: <CACsJy8D=72RsnNKs-6EdUnhu6kurvQ5S2z5PkV3KcY7SUDHJKg@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234655>

On Tue, 10 Sep 2013, Duy Nguyen wrote:

> On Mon, Sep 9, 2013 at 10:01 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > However this means that the progress meter will now be wrong and that's
> > terrible !  Users *will* complain that the meter doesn't reach 100% and
> > they'll protest for being denied the remaining objects during the
> > transfer !
> >
> > Joking aside, we should think about doing something about it.  I was
> > wondering if some kind of prefix to the pack stream could be inserted
> > onto the wire when sending a pack v4.  Something like:
> >
> > 'T', 'H', 'I', 'N', <actual_number_of_sent_objects_in_network_order>
> >
> > This 8-byte prefix would simply be discarded by index-pack after being
> > parsed.
> >
> > What do you think?
> 
> I have no problem with this. Although I rather we generalize the case
> to support multiple packs in the same stream (in some case the server
> can just stream away one big existing pack, followed by a smaller pack
> of recent updates), where "thin" is just a special pack that is not
> saved on disk. So except for the signature difference, it should at
> least follow the pack header (sig, version, nr_objects)

Except in this case this is not a separate pack.  This prefix is there 
to provide information that is valid only for the pack to follow and 
therefore cannot be considered as some independent data.


Nicolas
