From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 12:23:17 +1300
Message-ID: <47855765.9090001@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 00:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCkH6-0005Pk-WB
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 00:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbYAIXXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 18:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbYAIXXa
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 18:23:30 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:58446 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895AbYAIXX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 18:23:29 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id A3F8A21D185; Thu, 10 Jan 2008 12:23:23 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id C494C21D183;
	Thu, 10 Jan 2008 12:23:17 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70026>

Junio C Hamano wrote:
> Note that the space nor time performance of compressing and
> uncompressing a single huge blob is not as interesting in the
> context of git as compressing/uncompressing millions of small
> pieces whose total size is comparable to the specimen of "huge
> single blob" experiment.  Obviously loose object files are
> compressed individually, and packfile contents are also
> individually and independently compressed.  Set-up cost for
> individual invocation of compression and uncompression on
> smaller data matters a lot more than an experiment on
> compressing and uncompressiong a single huge blob (this applies
> to both time and space).

Yes - and lzo will almost certainly win on all those counts!

I think to go forward this would need a prototype and benchmark figures
for things like "annotate" and "fsck --full" - but bear in mind it would
be a long road to follow-up to completion, as repository compatibility
would need to be a primary concern and this essentially would create a
new pack type AND a new *object* type.  Not only that, but currently
there is no header in the objects on disk which can be used to detect a
gzip vs. an lzop stream.  Not really worth it IMHO - gzip is already
fast enough on even the most modern processor these days.

Sam.
