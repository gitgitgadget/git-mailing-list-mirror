From: karl <karl.okeeffe@kuluvalley.com>
Subject: Re: Problems with git-svn and space in the URL
Date: Wed, 28 Sep 2011 07:04:41 -0700 (PDT)
Message-ID: <1317218681291-6840304.post@n2.nabble.com>
References: <13CB2F6C-49BB-44CB-84A7-2264CAF76766@sky4studios.be> <0A790195-2DB1-4E1F-BAE2-9D65C261AD26@sky4studios.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 16:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ukh-0001AV-Jk
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab1I1OEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:04:42 -0400
Received: from sam.nabble.com ([216.139.236.26]:35280 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042Ab1I1OEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:04:42 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <karl.okeeffe@kuluvalley.com>)
	id 1R8ukb-0003N7-9f
	for git@vger.kernel.org; Wed, 28 Sep 2011 07:04:41 -0700
In-Reply-To: <0A790195-2DB1-4E1F-BAE2-9D65C261AD26@sky4studios.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182316>

I was able to work around this issue by patching git-svn.

I updated the url_path function to:


sub url_path {
	my ($self, $path) = @_;

	my $url = $self->{url} . '/' . $self->repo_path($path);
	if ($self->{url} =~ m#^https?://#) {
		$url =~ s!([^~a-zA-Z0-9_./-])!uc sprintf("%%%02x",ord($1))!eg;
                $url =~ s!^(https?)%3A//!$1://!;
	}
    $url
}


This ensures that the spaces in the url are encoded correctly.

It seems to work for me, but hasn't been tested thoroughly.

--
View this message in context: http://git.661346.n2.nabble.com/Problems-with-git-svn-and-space-in-the-URL-tp5120361p6840304.html
Sent from the git mailing list archive at Nabble.com.
