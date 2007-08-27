From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 15:16:28 +0000 (UTC)
Message-ID: <loom.20070827T170518-603@post.gmane.org>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr> <7vps19jnm1.fsf@gitster.siamese.dyndns.org> <vpqtzql17gd.fsf@bauges.imag.fr> <20070827130346.GA8821@glandium.org> <Pine.LNX.4.64.0708271440500.28586@racer.site> <866431rser.fsf@lola.quinscape.zz> <20070827141600.GA11000@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 17:16:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgKg-0002wz-ST
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbXH0PQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbXH0PQr
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:16:47 -0400
Received: from main.gmane.org ([80.91.229.2]:58755 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471AbXH0PQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:16:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPgKT-0003fA-Qc
	for git@vger.kernel.org; Mon, 27 Aug 2007 17:16:40 +0200
Received: from creinus-web.us.es ([150.214.9.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:16:37 +0200
Received: from scallegari by creinus-web.us.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:16:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 150.214.9.245 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20061201 Firefox/2.0.0.6 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56847>

Mike Hommey <mh <at> glandium.org> writes:


> 
> A zipped file will be 100% different at each revision.
> The unzipped counterpart may be similar for 90% or more between revisions.
> 
> Mike
> 

In my (modest) experience, not really:

in fact, odf files are a zip collection of many individual files (for instance
if you have an impress presentation, the zip collection will contain all
the images that appear in the presentation...)

Now: zip is different from .tar.gz in that tar.gz first concatenates the
files and then compresses the overall thing, while zip compresses or stores
the individual files and then concatenates and indexes the result.

The difference is that in a tar.gz file, changing a single byte in one of
the internal files can lead to a completely different compressed stream,
while in a zip file, changing an internal file only affects the relevant
part of the zipped file.

This means that:
- if you have an odf document containing lots of internal objects (e.g.
images) that do not change very much from version to version, git can make
very good deltas.
- conversely if you have an odf document whose size is dominated by proper
content, then git will not be able to make good deltas.

As an example, I am finding that impress presentations (dominated by images)
can delta very well, while calc spreadsheets (dominated by content) do not.

Probably it could be nice to make a filter that takes an odf file and 
re-zips it so that the content.xml inner file is only stored, rather
than deflated.  Then this could be used with the git file filtering
machinery.

Sergio
