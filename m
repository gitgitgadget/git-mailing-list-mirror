From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 13:47:11 +0200
Message-ID: <40aa078e0907280447p4ed92133jb5e586fb0ca40ef2@mail.gmail.com>
References: <200907280446.22890.elendil@planet.nl>
	 <200907281127.44558.trast@student.ethz.ch>
	 <20090728104423.GA12947@vidovic>
	 <200907281313.51304.elendil@planet.nl>
	 <20090728113814.GB12947@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frans Pop <elendil@planet.nl>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 13:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVl9R-00089f-6w
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 13:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbZG1LrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 07:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbZG1LrQ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 07:47:16 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:45964 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbZG1LrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 07:47:15 -0400
Received: by fxm12 with SMTP id 12so67515fxm.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7vasSsBnuxl0u/BwF771PkUq/Syc0C5vz+YbyPGNZYc=;
        b=UtMCgQBKM49pRR4fffMw9VoiV4Wv1E4+eWrzfaY5OiqCTINafDVefWcmcxpSE3aUZP
         fuGIqdymQNBQ3FQASQsACAD3ftY0zez7vO8w0kxTKjVFboj+cft9akdBpQeI1iP2U61f
         z09CUMvsuOOtKoFEKIK8gNBNOomK1gNCnp/58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AJMZZcn2sbexYjb+ORcPv2bxtVq7xieQEYoY6a/yvRaXVcPbgQakB+djyk0hQpV1Vp
         4MhB8bMlinkqSl0UtTBBRf+IDwOPg3LPU7pGLEeK6JX+eLjsdCPWw00VqtoVK3OQRPp9
         YNjan2E+8VR3SYh6abb6cI27hvd+hyF7QJcBI=
Received: by 10.204.66.2 with SMTP id l2mr4090834bki.177.1248781631737; Tue, 
	28 Jul 2009 04:47:11 -0700 (PDT)
In-Reply-To: <20090728113814.GB12947@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124240>

On Tue, Jul 28, 2009 at 1:38 PM, Nicolas Sebrecht<nicolas.s.dev@gmx.fr> wrote:
> Hum, you're right. The '@' symbol is required, whatever "id-right" is.
> My previous patch should fix it.

With all due respect, I don't see how that patch fixes anything. The
previous last-resort solution should already be just as valid, it
assigns 'user@'+hostname to $du_part. Even if hostname is "" it should
insert an '@', which didn't happen here.

I'm suspecting that git-send-email in v1.5.2.5 didn't do enough
checks, and that this is an already-solved issue. Looking at the
source code from v1.5.2.5 seems to confirm this.
http://repo.or.cz/w/git.git?a=blob;f=git-send-email.perl;h=7c0c90bd21bbb009de81aa315bed1c947a32c423;hb=b13ef4916ac5a25cc5897f85ba0b4c5953cff609

my $message_id_from = extract_valid_address($from);
my $message_id_template = "<%s-git-send-email-$message_id_from>";

sub make_message_id
{
	my $date = time;
	my $pseudo_rand = int (rand(4200));
	$message_id = sprintf $message_id_template, "$date$pseudo_rand";
	#print "new message id = $message_id\n"; # Was useful for debugging
}

So I think it's pretty safe to disregard this as an already solved issue.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
