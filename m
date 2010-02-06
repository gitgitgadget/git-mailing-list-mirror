From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/4] gitweb: show notes in log
Date: Sat, 6 Feb 2010 13:57:57 +0100
Message-ID: <201002061357.59245.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <1265300338-25021-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 13:58:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdkEp-0004DX-P2
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 13:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab0BFM6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 07:58:06 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34161 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab0BFM6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 07:58:05 -0500
Received: by bwz19 with SMTP id 19so576198bwz.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 04:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=B0oX0FPxSD6RnfgXkCt65RQE4TwXbGcD44yePPKA+6A=;
        b=YmsGNApgn8xBbwJ4Gq51fCi0BuCghdG2dsEDbIYczgoK18L4P6IbZ3ATjnVoKP2JZv
         UR4ye988EnMx65e54E13kc2OxJnTt1UW3di+1FF/jgrUFVoBTa1HsjX0qYvo5QeVMsP2
         IA4ZIve9K6ioSYCTE3SqLzQR4nQoFW3BOv3jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H6NEi3XybOYXwLvdRYNXTdW/Hn43QzGbd8eW4ofAIyKrWg+w47TPI+AwntiD4M6nOz
         GYX/zzcRYY84aQEAnKuyuLamhLeC/in485fHSWaHdOfRmNulKpkuBO72W8HNIV68UfBg
         VWUBhp9EHh36ncOIgiXkj/ONe8jdokqHgex/8=
Received: by 10.204.9.134 with SMTP id l6mr2734476bkl.83.1265461083499;
        Sat, 06 Feb 2010 04:58:03 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id 13sm1117033bwz.6.2010.02.06.04.58.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 04:58:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1265300338-25021-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139161>

On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:

> The notes are shown in full to the left of the log message.

Thats all good if you have wide (high resolution) screen, and your 
project follows common commit message conventions of keeping lines in 
commit message no longer than at most 80 characters, and you don't need 
to use large size fonts.

What happens if screen size is too small to contain both commit message 
and notes?  Does it do the sensible thing of putting notes _below_ 
commit message in such situation?  I do not know CSS+HTML enogh to 
answer this question myself.

BTW. signoff?


P.S. We would probably want some support for notes also in feeds (Atom 
and RSS feed), but this can be left for the future commit.


> @@ -1631,6 +1631,7 @@ sub format_subject_html {
>  # display notes next to a commit
>  sub format_notes_html {
>  	my %notes = %{$_[0]};
> +	my $tag = $_[1] || 'span' ;

This could be

   	my $notes = shift;
   	my $tag = shift || 'span' ;

and then use %$notes.

>  	my $ret = "";
>  	while (my ($ref, $text) = each %notes) {
>  		# remove 'refs/notes/' and an optional final s
> @@ -1639,15 +1640,15 @@ sub format_notes_html {
>  
>  		# double markup is needed to allow pure CSS cross-browser 'popup'
>  		# of the note
> -		$ret .= "<span title='$ref' class='note-container $ref'>";
> -		$ret .= "<span title='$ref' class='note $ref'>";
> +		$ret .= "<$tag title='$ref' class='note-container $ref'>";
> +		$ret .= "<$tag title='$ref' class='note $ref'>";
>  		foreach my $line (split /\n/, $text) {
>  			$ret .= esc_html($line) . "<br/>";
>  		}
> -		$ret .= "</span></span>";
> +		$ret .= "</$tag></$tag>";
>  	}
>  	if ($ret) {
> -		return "<span class='notes'>$ret</span>";
> +		return "<$tag class='notes'>$ret</$tag>";
>  	} else {
>  		return $ret;
>  	}

Nice trick, but is this distinction really necessary?

> @@ -4581,6 +4582,7 @@ sub git_log_body {
>  		next if !%co;
>  		my $commit = $co{'id'};
>  		my $ref = format_ref_marker($refs, $commit);
> +		my $notes = format_notes_html($co{'notes'}, 'div');
>  		my %ad = parse_date($co{'author_epoch'});
>  		git_print_header_div('commit',
>  		               "<span class=\"age\">$co{'age_string'}</span>" .
> @@ -4598,6 +4600,7 @@ sub git_log_body {
>  		      git_print_authorship(\%co, -tag => 'span');
>  		      print "<br/>\n</div>\n";
>  
> +		print "$notes\n";
>  		print "<div class=\"log_body\">\n";
>  		git_print_log($co{'comment'}, -final_empty_line=> 1);
>  		print "</div>\n";

With respect to the question about what happens if the screen is not 
wide enough, shouldn't notes be put in HTML source below body (commit 
message)?

-- 
Jakub Narebski
Poland
