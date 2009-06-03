From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 22:19:57 +0200
Message-ID: <200906032220.00238.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906031851.12160.jnareb@gmail.com> <20090603165613.GJ3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:15:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBws0-00029d-Li
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 22:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbZFCUPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbZFCUPV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 16:15:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:15556 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZFCUPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 16:15:20 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1254220fga.17
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dZVBNxoq+c9DFHmU6ouD2oWs4XS+xvmG/ws5PGA/5OU=;
        b=ZV4+ZogQDEPgCQZ/nMyuFtW39fIT9LNEYtm4UipJ3uJM8RMNhvkpbXNUCr7sNVPa8W
         T5Hajm6i7mROf8IWfnA4eeqz8nb3BNBL/p4H9ItCstLio3KAkSlJDBOPsJvUPAcIs7dY
         GZqPBshZXhiBoBm53REkdeB28Z4MnFUCKEi34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AXr+sIT7TSP7qtFa2HiwXKpmU6iiJ5FE5NSiDBLcXRnbLLgJX+A4PeNO8kHOJpvR6M
         sRs8oBR7+wct9Un6U6Ad5wTTGF1JG7qrEEs4gAeG3aCTAAMEv98mzIW/kqrtzaq1icg4
         ZZ50VSuwsIrEV2e6eb8BpMUYEa8fQw5ZpiGqU=
Received: by 10.86.57.9 with SMTP id f9mr1685358fga.33.1244060121468;
        Wed, 03 Jun 2009 13:15:21 -0700 (PDT)
Received: from ?192.168.1.13? (abws210.neoplus.adsl.tpnet.pl [83.8.242.210])
        by mx.google.com with ESMTPS id 3sm81943fge.11.2009.06.03.13.15.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 13:15:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090603165613.GJ3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120635>

Shawn O. Pearce <spearce@spearce.org> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> On Wed, 3 Jun 2009, Shawn O. Pearce wrote:

>>> Oh, and send-pack/receive-pack protocol now has ".have" refs [...]
>> 
>> What are those ".have" refs? They are not described in current version
>> of "Transfer Protocols" (sub)section in "The Community Book". I remember
>> that they were discussed on git mailing list, but I don't remember what
>> they were about...
> 
> If the remote receiving repository has alternates, the ".have" refs are
> the refs of the alternate repositories.  This signals to the client that
> the server has these objects reachable, but the client isn't permitted
> to send commands to alter these refs.
> 
> Its good for a site like GitHub or repo.or.cz where cheap forks are
> implemented by creating a repository that points to a common shared
> base via alternates.  The ".have" refs say that the server already
> has everything in that common shared base, so the client doesn't
> have to re-upload the entire project if the fork started out empty,
> or had all refs deleted from it.

So the output (for fetch or clone) would look like this for repository
with alternates (shared object database):

  00887b68fcd777f94534f0b794c5dc2e109c49938395 HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag\n
  0048a6afbb5c9618395ed28a299f0913e9e6df2058ef refs/heads/adaptive-filter\n
  004bbc60ab88b6899573fb545c6b4961f8ff3ce20695 refs/heads/filtered-to-window\n
  003f7b68fcd777f94534f0b794c5dc2e109c49938395 refs/heads/master\n
  0044226d09c3b5e16b5c1bd377aae9459cae3f778847 refs/heads/save-config\n
  0050dab192738152e1fa7233e06d941f9ada865c6e65 refs/tags/jnareb@gmail.com-gpg-pub\n
  00535812582f41a234828c8a2ec38047462979dc5dd8 refs/tags/jnareb@gmail.com-gpg-pub^{}\n
  003c50808bc27817eac090683e44fce4368fff39f9b2 refs/tags/v1.2\n
  0033b11cf09043f18b368ec0d988f064ea21247c843d .keep\n

Does it matter for fetch, or is it important only for pushing?


BTW. do "include-tag" capability MUST NOT (REQUIRED) be send if there
are not tags (tag objects?), or just SHOULD NOT (RECOMMENDED), or even
MAY NOT (OPTIONAL).  GitHub server doesn't send it if there are no 
tags...

-- 
Jakub Narebski
Poland
