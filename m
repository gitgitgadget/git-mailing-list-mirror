X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x  proxying
Date: Fri, 24 Nov 2006 05:48:00 +0100
Message-ID: <200611240548.00840.chriscool@tuxfamily.org>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 04:40:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32187>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnSrX-0002Zh-9e for gcvg-git@gmane.org; Fri, 24 Nov
 2006 05:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757411AbWKXEk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 23:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757597AbWKXEk2
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 23:40:28 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:19167 "EHLO
 smtp2-g19.free.fr") by vger.kernel.org with ESMTP id S1757411AbWKXEk1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 23:40:27 -0500
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net
 [82.243.130.161]) by smtp2-g19.free.fr (Postfix) with ESMTP id 483107A23;
 Fri, 24 Nov 2006 05:40:26 +0100 (CET)
To: Inaki Arenaza <iarenuno@eteo.mondragon.edu>
Sender: git-owner@vger.kernel.org

Inaki Arenaza wrote:

[...]

>
> +		my ($s, $rep);
> +		if($proxyhost) {
> +
> +			# Use a HTTP Proxy. Only works for HTTP proxies that
> +			# don't require user authentication
> +			#
> +			# See: http://www.ietf.org/rfc/rfc2817.txt
> +
> +			$s = IO::Socket::INET->new(PeerHost => $proxyhost, PeerPort =>
> $proxyport); +			die "Socket to $proxyhost: $!\n" unless defined $s;
> +			$s->write("CONNECT $serv:$port HTTP/1.1\r\nHost:
> $serv:$port\r\n\r\n") +	                        or die "Write to
> $proxyhost: $!\n";
> +	                $s->flush();
> +
> +			$rep = <$s>;
> +
> +			# The answer should loook like 'HTTP/1.x 2yy ....'
> +			if(!($rep =~ m#^HTTP/1\.. 2[0-9][0-9]#)) {
> +				die "Proxy connect: $rep\n";
> +			}
> +			# Skip the empty line of the proxy server output
> +			<$s>;
> +		} else {
> +			my $s = IO::Socket::INET->new(PeerHost => $serv, PeerPort => $port);

It seems that "my " should not be in the above line.

> +			die "Socket to $serv: $!\n" unless defined $s;
> +		}
> +
>  		$s->write("BEGIN AUTH REQUEST\n$repo\n$user\n$pass\nEND AUTH
> REQUEST\n") or die "Write to $serv: $!\n";
>  		$s->flush();

Regards,
