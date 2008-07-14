From: Nicolas Pitre <nico@cam.org>
Subject: Re: [BUG] commit walk machinery is dangerous !
Date: Mon, 14 Jul 2008 19:39:08 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807141937180.12484@xanadu.home>
References: <alpine.LFD.1.10.0807141641110.12484@xanadu.home>
 <7vbq10f7wr.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807141904250.12484@xanadu.home>
 <7vod50dote.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXeL-0008RX-46
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759560AbYGNXjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759559AbYGNXjK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:39:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46487 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759334AbYGNXjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:39:09 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4000IQRSD8LCM0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 19:39:08 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vod50dote.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88481>

On Mon, 14 Jul 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > It is those with semantic meaning (e.g. object doesn't exist) which 
> > should be audited, especially if used in the context of repository 
> > modification, which pretty much limits it to the test case I produced.
> 
> I've been wondering if we should make the change 8eca0b4 (implement some
> resilience against pack corruptions, 2008-06-23) less aggressive.
> 
> It makes loose objects and data from other packs to be used as fallback
> where we used to just punt, which is a genuine improvement for "salvaging"
> mode of operation, but at the same time, it now forbids the callers to
> expect that the objects they learned to exist from has_sha1_file() or
> nth_packed_object_sha1() should never result NULL return value from
> read_sha1_file().
> 
> It may make it safe again to fail if you cannot salvage using fallback
> method after all.  Something like the attached.

Well, I have a different solution which should restore the original 
"behavior" in the presence of existing but non-readable objects.  Patch 
will follow later.


Nicolas
