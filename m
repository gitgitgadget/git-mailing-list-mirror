From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table
 size
Date: Mon, 09 Sep 2013 15:11:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309091507290.20709@syhkavp.arg>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-16-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
 <xmqq61u94zew.fsf@gitster.dls.corp.google.com>
 <alpine.LFD.2.03.1309091441540.20709@syhkavp.arg>
 <xmqqwqmp3jtj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 21:11:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ6sN-0000Jo-LZ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 21:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab3IITLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 15:11:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21006 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab3IITLv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 15:11:51 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSV00430HBF65B0@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Sep 2013 15:11:39 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 0E3E22DA0625; Mon, 09 Sep 2013 15:11:39 -0400 (EDT)
In-reply-to: <xmqqwqmp3jtj.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234360>

On Mon, 9 Sep 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> > ...  I was 
> >> > wondering if some kind of prefix to the pack stream could be inserted 
> >> > onto the wire when sending a pack v4.  Something like:
> >> >
> >> > 'T', 'H', 'I', 'N', <actual_number_of_sent_objects_in_network_order>
> >> >
> >> > This 8-byte prefix would simply be discarded by index-pack after being 
> >> > parsed.
> >> >
> >> > What do you think?
> >> 
> >> I do not think it is _too_ bad if the meter jumped from 92% to 100%
> >> when we finish reading from the other end ;-), as long as we can
> >> reliably tell that we read the right thing.
> >
> > Sure.  but eventually people will complain about this.  So while we're 
> > about to introduce a new pack format anyway, better think of this little 
> > cosmetic detail now when it can be included in the pack v4 capability 
> > negociation.
> 
> Oh, I completely agree on that part.  When we send a self-contained
> pack, would we send nothing?  That is, should the receiving end
> expect and rely on that the sending end will send a thin pack and
> never a fat pack when asked to send a thin pack (and vice versa)?
> 
> Also should we make the "even though we have negotiated the protocol
> parameters, after enumerating the objects and deciding what the pack
> stream would look like, we have a bit more information to tell you"
> the sending side gives the receiver extensible?  I am wondering if
> that prefix needs something like "end of prefix" marker (or "here
> comes N-bytes worth of prefix information" upfront); we probably do
> not need it, as the capability exchange will determine what kind of
> information will be sent (e.g. "actual objects in the thin pack data
> stream").

Do we know the actual number of objects to send during the capability 
negociation?  I don't think so as this is known only after the 
"compressing objects" phase, and that already depends on the capability 
negociation before it can start.


Nicolas
