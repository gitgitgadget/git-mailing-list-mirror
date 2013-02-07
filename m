From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/5] git-send-email: use git credential to obtain
 password
Date: Thu, 07 Feb 2013 10:42:24 -0800
Message-ID: <7vd2wc7ypb.fsf@alter.siamese.dyndns.org>
References: <cover.1360242782.git.mina86@mina86.com>
 <cover.1360242782.git.mina86@mina86.com>
 <0b3c9b66ccb6c8343dafd210b82c7765891d3785.1360242782.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:42:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3WQu-0002HD-9l
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 19:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281Ab3BGSm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 13:42:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756684Ab3BGSm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 13:42:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AD5FCF08;
	Thu,  7 Feb 2013 13:42:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tfCbBSXQTJ5eZ7clBGTFZufibUw=; b=Qm/zrm
	83zYtLFYU7h3WSV+LtD9KvpAZp7umqul+GBbdQOw9nR05z7JMgjTUDd6VoyZ08LB
	SPpauUd1yJlOdDeRKw7rS301zFrixrat7ggLosQ2E+jNqp41IqUsPbaLq0z4BcHp
	en3XefK88DQ81CRRU/lDwNBWmppPwru9WcugU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D2a581CXsZCut+oDryP/6ZZj/javwcAb
	+TnmNenw9bv23hanRa/L1gTH32MM91Tr8iP5Wx3DpZ722bzMhl/+Q2+utFA4d2zb
	tOHoR1W2Ss8Lnm1/BvuYCF4huoIEbedsM5tJoeGcEDBJUYh6k860MQB/IbEeAq82
	iX2kKOckEVU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6445FCF00;
	Thu,  7 Feb 2013 13:42:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4610ACEFA; Thu,  7 Feb 2013
 13:42:26 -0500 (EST)
In-Reply-To: <0b3c9b66ccb6c8343dafd210b82c7765891d3785.1360242782.git.mina86@mina86.com>
 (Michal Nazarewicz's message of "Thu, 7 Feb 2013 15:01:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E5CEBC0-7156-11E2-9810-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215710>

Michal Nazarewicz <mpn@google.com> writes:

> From: Michal Nazarewicz <mina86@mina86.com>
>
> If smtp_user is provided but smtp_pass is not, instead of
> prompting for password, make git-send-email use git
> credential command instead.
>
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> ---

Nice ;-)

I'd expect reviews on 4/5 from Peff and Matthiew which may result in
either Reviewed-by:'s or another round, but everything else looks in
good order.

Thanks to all three of you for working on this.

>  Documentation/git-send-email.txt |  4 +--
>  git-send-email.perl              | 59 +++++++++++++++++++++++-----------------
>  2 files changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 44a1f7c..0cffef8 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -164,8 +164,8 @@ Sending
>  Furthermore, passwords need not be specified in configuration files
>  or on the command line. If a username has been specified (with
>  '--smtp-user' or a 'sendemail.smtpuser'), but no password has been
> -specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
> -user is prompted for a password while the input is masked for privacy.
> +specified (with '--smtp-pass' or 'sendemail.smtppass'), then
> +a password is obtained using 'git-credential'.
>  
>  --smtp-server=<host>::
>  	If set, specifies the outgoing SMTP server to use (e.g.
> diff --git a/git-send-email.perl b/git-send-email.perl
> index be809e5..76bbfc3 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1045,6 +1045,39 @@ sub maildomain {
>  	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
>  }
>  
> +# Returns 1 if authentication succeeded or was not necessary
> +# (smtp_user was not specified), and 0 otherwise.
> +
> +sub smtp_auth_maybe {
> +	if (!defined $smtp_authuser || $auth) {
> +		return 1;
> +	}
> +
> +	# Workaround AUTH PLAIN/LOGIN interaction defect
> +	# with Authen::SASL::Cyrus
> +	eval {
> +		require Authen::SASL;
> +		Authen::SASL->import(qw(Perl));
> +	};
> +
> +	# TODO: Authentication may fail not because credentials were
> +	# invalid but due to other reasons, in which we should not
> +	# reject credentials.
> +	$auth = Git::credential({
> +		'protocol' => 'smtp',
> +		'host' => join(':', $smtp_server, $smtp_server_port),
> +		'username' => $smtp_authuser,
> +		# if there's no password, "git credential fill" will
> +		# give us one, otherwise it'll just pass this one.
> +		'password' => $smtp_authpass
> +	}, sub {
> +		my $cred = shift;
> +		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
> +	});
> +
> +	return $auth;
> +}
> +
>  # Returns 1 if the message was sent, and 0 otherwise.
>  # In actuality, the whole program dies when there
>  # is an error sending a message.
> @@ -1185,31 +1218,7 @@ X-Mailer: git-send-email $gitversion
>  			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
>  		}
>  
> -		if (defined $smtp_authuser) {
> -			# Workaround AUTH PLAIN/LOGIN interaction defect
> -			# with Authen::SASL::Cyrus
> -			eval {
> -				require Authen::SASL;
> -				Authen::SASL->import(qw(Perl));
> -			};
> -
> -			if (!defined $smtp_authpass) {
> -
> -				system "stty -echo";
> -
> -				do {
> -					print "Password: ";
> -					$_ = <STDIN>;
> -					print "\n";
> -				} while (!defined $_);
> -
> -				chomp($smtp_authpass = $_);
> -
> -				system "stty echo";
> -			}
> -
> -			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
> -		}
> +		smtp_auth_maybe or die $smtp->message;
>  
>  		$smtp->mail( $raw_from ) or die $smtp->message;
>  		$smtp->to( @recipients ) or die $smtp->message;
