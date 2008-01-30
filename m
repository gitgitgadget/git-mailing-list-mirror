From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Wed, 30 Jan 2008 18:55:46 +1300
Message-ID: <47A01162.7070503@vilain.net>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 06:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK5vz-00051x-Kp
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 06:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034AbYA3Fz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 00:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757021AbYA3Fz6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 00:55:58 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:57631 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756974AbYA3Fz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 00:55:57 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 37A7421D170; Wed, 30 Jan 2008 18:55:55 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id C739321D125;
	Wed, 30 Jan 2008 18:55:51 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20080130042201.GO24004@spearce.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72027>

Shawn O. Pearce wrote:
> I just read the GnuPG manual and you are obviously correct.  The only
> way to get GnuPG to process a key is to load it onto a keyring.
> We could extract the armored (or binary) public key and load it
> onto a temporary keyring created just for the purpose of verifying
> this connection, but that's rather messy.

It should be fine just to throw the lot into a single keyring, and just
check which key verified it after the fact and whether that key was allowed.

The Perl Crypt::OpenPGP module doesn't suffer from this problem (and is
performant), though it suffers from a dependency stack that will hurt
everyone except Debian users ;-).

I think this is a non-issue.

>> $ gpg --keyring path/to/the/keyring.gpg --quiet --batch --status-fd 1 --verify some-file.tar.gz.gpg 2>|/dev/null
>> [GNUPG:] SIG_ID dw0VliO0DFjOQA3HUSHijYekQYY 2008-01-29 1201633002
>> [GNUPG:] GOODSIG BC6AFB5BA1EE761C Pierre Habouzit <pierre.habouzit@polytechnique.edu>
>> [GNUPG:] VALIDSIG 72B4C59ADA78D70E055C129EBC6AFB5BA1EE761C 2008-01-29 1201633002 0 3 0 17 2 00 72B4C59ADA78D70E055C129EBC6AFB5BA1EE761C
^^^ there GPG just told you which key was used.
>> [GNUPG:] TRUST_ULTIMATE

Sam.
