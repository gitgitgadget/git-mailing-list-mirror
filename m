From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 8/9] gitweb: use picon for gravatar fallback
Date: Sun, 28 Jun 2009 16:42:36 +0200
Message-ID: <200906281642.36410.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-8-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-9-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 16:37:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKvVN-0004hv-RL
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 16:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbZF1OhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 10:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbZF1OhG
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 10:37:06 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55980 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbZF1OhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 10:37:04 -0400
Received: by bwz9 with SMTP id 9so2816562bwz.37
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=oZmB3RqzR+8WA8rlEStUFGJZ0H3CvcRvGtB/4vgIjQc=;
        b=Eua88B3H+QloTa3GXl7qdlXSEshAZTWlz5abJ489bSLVr22iEcHFui+1Sal3OFPjLL
         pUKh9MMLuQ/D2MJ69BxapWcpFVhKb2PnQzBM0snSwzaCSiDA6Hokj0qPevmAJSb/DTfe
         3jGfef+fUoHmQtfHr3EN6xavLE8VSFTTXbVI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Gp8E5KkKAP/Nf0oKHu+B7oLrr0Mx0SZUb3p/piv+P3/L+8MyBsGOZb7ugeUP81m1mM
         SA52aLnKkd3Z1EiZF5gMHfY6FBcuyz0YRualVLFsgMxhRdicCxD9g4+kg/Q9M/10mJXl
         EYDR6HC4nmbWV8fAs5m3RtUXsjZr8/Vimw6qM=
Received: by 10.103.227.13 with SMTP id e13mr3487647mur.2.1246199826613;
        Sun, 28 Jun 2009 07:37:06 -0700 (PDT)
Received: from ?192.168.1.13? (abvg228.neoplus.adsl.tpnet.pl [83.8.204.228])
        by mx.google.com with ESMTPS id e8sm19807035muf.36.2009.06.28.07.37.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 07:37:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-9-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122407>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:

I think this issue is complicated enough to do it well and configurable
that it is out of scope of current patch series, and it would be better
to be left for next series.

.......................................................................

There are few issues connected with multiple avatar providers:

1. Avatar provider side fallback, i.e. what to do if given person
(usually given email address) is not registered with used avatar 
provider. 

Gravatar provider by default falls back to [G] gravatar default image,
and you can specify fallback using 'd'/'default' parameter, either to
one of defined providers: special values "identicon", "monsterid" and
"wavatar", or to specified image using URI-encoded URL as value of 
'default' parameter.  From the point of view of gitweb, you either
pass provider or URL literally (encoding), or you resolve fallback
provider avatar and pass encoded URI.

Picon provider has built-in many level fallback; current gitweb 
implementation searches in 'users' database, then in 'domains'
database (there e.g. gmail.com domain addresses receive GMail
avatar), and last in 'unknown' database which would always provide
some default avatar for "person".  But in general one can use 
cs.indiana.edu database as fallback, and try personal / local site
database first.

2. Gitweb side fallback; for some kinds of avatars one can think about,
for example 'local' avatars (example URL: "avatar/user.gif"), or 'inrepo'
avatar provider (example URL: "?p=$project;a=blob_plain;f=avatar/user.gif"),
one can easily detect in gitweb if avatar for given email (given person)
exists or not (is available or not).

3. Multiple avatars.  We can use here something like what Gmane does,
which shows gravatar if it is available (and nothing if it is not), 
picon if it is available (and nothing if it is not), and both picon
and gravatar if both are available.  See example in:
  http://permalink.gmane.org/gmane.comp.version-control.git/122394
  http://permalink.gmane.org/gmane.comp.version-control.git/118058


This patch tries to address issue 1.) for gravatar provider (which allow
for specifying default avatar via its URL API).  I think however that
this issue should be configurable; unconditional using picon provider
with very long URI (making gravatar-with-picon-fallback provider URI
very, very long) is not a good idea.

By configurable I mean that user should be able to specify e.g. gravatar
with wavatar fallback, gravatar with static image fallback, and gravatar
with arbitrary provider (resolved) fallback.

Unless you wanted to provide this patch as an example of having multiple
providers / providing avatar fallback (default value).  But then it would
be better to have it marked as RFC explicitly...

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ae73d45..e2638cb 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1546,9 +1546,13 @@ sub picon_url {
>  sub gravatar_url {
>  	my $email = lc shift;
>  	my $size = shift;
> -	$avatar_cache{$email} ||=
> -		"http://www.gravatar.com/avatar.php?gravatar_id=" .
> -			Digest::MD5::md5_hex($email) . "&amp;size=";
> +	if (!$avatar_cache{$email}) {
> +		my $picon = CGI::escape(picon_url($email));

Sidenote: if we end requiring 'escape', we can simply import it.

> +		$avatar_cache{$email} = "http://www.gravatar.com/avatar.php?gravatar_id=" .
> +			Digest::MD5::md5_hex($email) .
> +			"&amp;default=$picon" .
> +			"&amp;size=";
> +	}
>  	return $avatar_cache{$email} . $size;
>  }

Nevertheless this is nice example that infrastructure created in previous
patches leads to adding such feature quite simple.

-- 
Jakub Narebski
Poland
