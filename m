From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 08 Sep 2011 13:57:05 +0300
Organization: Unix Solutions Ltd. (http://unixsol.org)
Message-ID: <4E689F81.6000305@unixsol.org>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org> <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com> <vpq7h5jtngj.fsf@bauges.imag.fr> <CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com> <CALkWK0nt4PXfBxGcAnavUkKM6AhKpZnw1NtZsNznzmGZiguFqA@mail.gmail.com> <CALkWK0mNBG8EwysjO8uoR+fU5ZM=Pz9es3t_+s6cFgR6NSodGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 12:57:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1cIE-0007Qr-FW
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 12:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264Ab1IHK5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 06:57:08 -0400
Received: from ns.unixsol.org ([193.110.159.2]:55781 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758223Ab1IHK5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 06:57:07 -0400
Received: from [10.0.1.78] ([::ffff:10.0.1.78])
  (AUTH: CRAM-MD5 gf, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by ns.unixsol.org with esmtp; Thu, 08 Sep 2011 13:57:05 +0300
  id 00140B8E.4E689F81.00007B94
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110712 Thunderbird/5.0
In-Reply-To: <CALkWK0mNBG8EwysjO8uoR+fU5ZM=Pz9es3t_+s6cFgR6NSodGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180963>

Around 09/08/2011 01:44 PM, Ramkumar Ramachandra scribbled:
> I mocked up a small patch to demonstrate the "special cover letter
> handling" idea.  Let me know if you think it's worth pursuing.
> Warning: Untested.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> -- 8< --
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 98ab33a..30b8651 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -80,6 +80,7 @@ git send-email [options] <file | directory |
> rev-list options >
>      --[no-]suppress-from           * Send to self. Default off.
>      --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default off.
>      --[no-]thread                  * Use In-Reply-To: field. Default on.
> +    --[no-]initial-wait     <int>  * Wait <int> seconds after sending
> first email.
> 
>    Administering:
>      --confirm               <str>  * Confirm recipients before sending;
> @@ -190,7 +191,7 @@ sub do_edit {
>  }
> 
>  # Variables with corresponding config settings
> -my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
> +my ($thread, $initial_wait, $chain_reply_to, $suppress_from,
> $signed_off_by_cc);
>  my ($to_cmd, $cc_cmd);
>  my ($smtp_server, $smtp_server_port, @smtp_server_options);
>  my ($smtp_authuser, $smtp_encryption);
> @@ -205,6 +206,7 @@ my $not_set_by_user = "true but not set by the user";
> 
>  my %config_bool_settings = (
>      "thread" => [\$thread, 1],
> +    "initialwait" => [\$initial_wait, 0],
>      "chainreplyto" => [\$chain_reply_to, $not_set_by_user],
>      "suppressfrom" => [\$suppress_from, undef],
>      "signedoffbycc" => [\$signed_off_by_cc, undef],
> @@ -1141,6 +1143,11 @@ X-Mailer: git-send-email $gitversion
>  		} else {
>  			print "Result: OK\n";
>  		}
> +		if ($initial_wait) {
> +			print "Sleeping: $initial_wait seconds.\n" if (!$quiet);
> +			sleep($initial_wait);
> +			$initial_wait = 0;
> +		}
>  	}
> 
>  	return 1;

I don't see how this would solve the problem that MTA can send
emails after the first one out of order.

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
