From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 12:28:35 +0200
Message-ID: <vpq392og8fg.fsf@bauges.imag.fr>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
	<CABPQNSYv1hd8RFHfcQ1XTB94nu6xo+tjj4CvWur29152z2dk6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@entel.upc.edu>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 11 12:28:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBNi9-0005ee-1G
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 12:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab2IKK2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 06:28:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35794 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696Ab2IKK2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 06:28:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8BAOCZ4031632
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Sep 2012 12:24:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBNhs-0006tP-5q; Tue, 11 Sep 2012 12:28:36 +0200
In-Reply-To: <CABPQNSYv1hd8RFHfcQ1XTB94nu6xo+tjj4CvWur29152z2dk6A@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 11 Sep 2012 12:06:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Sep 2012 12:24:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8BAOCZ4031632
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347963856.5849@JXPTH8nzS4gD8RaDfOKdfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205215>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> I have stumbled upon a similar issue on Windows (which also has a
> case-preserving filesystem), and I seem to remember the solution being
> something to do with packed refs.

Packed-refs use a format like this:

$ tail -3 .git/packed-refs
e94214ce4b8acefce06d4ea37b76ac0de11ecb2d refs/tags/v1.7.9.5
bf68fe0313c833fa62755176f6e24988ef7cf80f refs/tags/v1.7.9.6
3996bb24c84013ec9ce9fa0980ce61f9ef97be4d refs/tags/v1.7.9.7

so the ref name is stored within the file, not as the file name. So,
yes, packing refs (done by "git pack-refs", called by "git gc" among
other things) should solve case-insensitive issues.

However, creating or updating refs after a pack will still create
unpacked refs, so this solves the issue only if one of the colliding
branches is not updated anymore.

> Perhaps we could change Git to detect name-collisions and
> automatically pack the refs in such cases?

That's a bit harder than it seems, as the idea is to avoid re-writting
the packed-refs file for each ref update. Repacking after each colliding
ref update could be costly in terms of performance.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
