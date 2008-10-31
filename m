From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 17:26:56 +0100
Message-ID: <200810311726.57122.jnareb@gmail.com>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com> <m37i7pggnk.fsf@localhost.localdomain> <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Thanassis Tsiodras" <ttsiodras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:28:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvwrN-0007FJ-Ji
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbYJaQ1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbYJaQ1H
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:27:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:27424 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbYJaQ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:27:04 -0400
Received: by ug-out-1314.google.com with SMTP id 39so1287641ugf.37
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FJH0Dn5ON9rPBw5mHhRIOLr+OKaMZf7p3pH6/uZWAn8=;
        b=p8abih3G0ozhQkJy02oeXZ1d3TOEZhgReFmKX7oI0GkVfzHt3DT1373q2q+7Rs9rwf
         L64wLw91exEhe4CCSl/DrnzWJJMbOT82OCKPvkbxRIKYI2Q0eDe68FoXTf3e5Wh8EExK
         YAVfkeMbs3jUz/pssLxaHef5YsGx50e3ZkcxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FlSs7KiQ7ehcSwreDQb0bmEtmKMy2zomvuThtGDAjQND41jpYSX1p2dhVqWrYhR4gb
         uvAoa+WTKRlg/iHlRP1Aw7N+Ux5dtA7gqQaUXBQlLX9N5Hct2IqqjyrElmZpwsUpldZw
         FcvaTE1nnNq2ceOHId0wFOxQbBeFhLL3BEhRs=
Received: by 10.66.236.13 with SMTP id j13mr2840016ugh.7.1225470422560;
        Fri, 31 Oct 2008 09:27:02 -0700 (PDT)
Received: from ?192.168.1.11? (abwk207.neoplus.adsl.tpnet.pl [83.8.234.207])
        by mx.google.com with ESMTPS id 20sm5024853uga.49.2008.10.31.09.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 09:27:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99598>

Thanassis Tsiodras wrote:
> On Fri, Oct 31, 2008 at 1:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
 
> > Git does deltification _only_ in packfiles. But when you push via SSH
> > git would generate a pack file with commits the other side doesn't
> > have, and those packs are thin packs, so they also have deltas... but
> > the remote side then adds bases to those thin packs making them
> > standalone: you would have to git-gc on remote.
> 
> So I have to git-gc on my side (after the commits), git-gc on the remote,
> and then git-push?

Perhaps I haven't made myself clear.

On the local side: git-commit creates loose (compressed, but not
deltified) objects. git-gc packs and deltifies.

On the remote side (for smart protocols, i.e. git and ssh): git
creates _thin_ pack, deltified; on the remote side git either makes
pack thick/self contained by adding base objects (object + deltas),
or explodes pack into loose object (object). You need git-gc on
remote server to fully deltify on remote side. But transfer is fully
deltified.

On the remote side (for dumb protocols, i.e. rsync and http): git
finds required packs and transfers them whole. So the situation is
like on local side, but git might transfer more than really needed
because it transfers packs in full.

HTH.
-- 
Jakub Narebski
Poland
