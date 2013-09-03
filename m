From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: add filename search function
Date: Tue, 03 Sep 2013 13:07:48 -0700
Message-ID: <xmqqbo49r7mz.fsf@gitster.dls.corp.google.com>
References: <CANzJMBWDgtjbNwPLjoKniwy5xCGKyz0yBFiMBfdGJMi5Q=W4+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Durkin <cjdurkin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:08:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwtP-0003nH-Es
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760303Ab3ICUH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:07:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759990Ab3ICUH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:07:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7AD33FBB5;
	Tue,  3 Sep 2013 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kcxpjrwnBkVdNdyWh4mv0LHkYvI=; b=LhvA6L
	qm7GawyHO5pHgg/Foak3vTROPy+Mk3/fcogIcZNeiaB+iU6lZWU0HJBbWzHSruCr
	ORZaG1A4p+0gcJ6eDvrgwX9wRk/ilI6rxqFH8vFblnDDKYzoOFHdppnvkCQuvrpB
	aMttaAZ2Ufju/668nOITeA1+V8lObIozokd4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ORHIL4K50rABB8VRFJ1J2vMuoPCkKelG
	KS9Z75Tac3atEX61oSQEgjYYoFXh58xTLf802ZDCGVHOPJV9PGq2JQReXwn7ew8a
	8qgHBTVSIYZiKLen0goKo93BLccF+3OVBC6xG94e76aeJDBx0jshxXiohU4i9nqI
	PfQw7qMIszo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FF1B3FBB3;
	Tue,  3 Sep 2013 20:07:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 817893FB9D;
	Tue,  3 Sep 2013 20:07:52 +0000 (UTC)
In-Reply-To: <CANzJMBWDgtjbNwPLjoKniwy5xCGKyz0yBFiMBfdGJMi5Q=W4+Q@mail.gmail.com>
	(Christopher Durkin's message of "Wed, 14 Aug 2013 23:02:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 842F51BE-14D4-11E3-A073-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233773>

Christopher Durkin <cjdurkin@gmail.com> writes:

> Add another item to the search drop-down (author/committer/etc)
> to search for file names instead of file content. Output is similar
> to the grep contents output, with each entry linking to the file.
> ---

Missing sign-off.

>  gitweb/gitweb.perl | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f429f75..4a7b0a5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6360,6 +6360,65 @@ sub git_search_grep_body {
>   print "</table>\n";

I think this file is indented with HT, not a single SP.

>  }
>
> +sub git_search_filenames {
> +    my %co = @_;

... nor four SP.  One level of indent is a single HT.

> +    local $/ = "\n";
> +    my $match_limit = 1000;
> +
> +    open my $fd, "-|", git_cmd(), 'ls-tree', '--name-only',
> '--full-name', '-r',

Line-wrapped broken patch that cannot be applied (I see there are a
few more similar ones below).

> +      $co{'tree'} or die_error(500, "Open git-ls-tree failed");
> +
> +    git_header_html();
> +
> +    git_print_page_nav('','', $hash,$co{'tree'},$hash);
> +    git_print_header_div('commit', esc_html($co{'title'}), $hash);
> +
> +    print "<table class=\"filename_search\">\n";
> +    my $matches = 0;
> +    my $alternate = 1;
> +    my $file_href;
> +
> +    while (my $filename = <$fd>) {
> +        chomp $filename;
> +
> +        if ($matches > $match_limit) {
> +            print "<div class=\"diff nodifferences\">Too many
> matches, listing trimmed</div>\n";
> +            last;
> +        }
> +
> +        if ($search_use_regexp) {
> +            next unless ($filename =~ /$searchtext/);
> +        } else {
> +            next unless index($filename,$searchtext) >= 0;
> +        }
> +
> +        $matches++;
> +        $file_href = href(action=>"blob", hash_base=>$co{'id'},
> +                          file_name=>$filename);
> +
> + if ($alternate) {
> +    print "<tr class=\"dark\">\n";
> + } else {
> +    print "<tr class=\"light\">\n";
> + }
> + $alternate ^= 1;
> +
> +        print "<td class=\"list\">".
> +            $cgi->a({-href => $file_href, -class => "list"},
> esc_path($filename));
> + print "</td>\n";
> + print "</tr>\n";
> +    }
> +
> +    if ($matches == 0) {
> +        print "<div class=\"diff nodifferences\">No matches found</div>\n";
> +    }
> +    close $fd;
> +
> +    print "</table>\n";
> +
> +    git_footer_html();
> +}
> +
>  ## ======================================================================
>  ## ======================================================================
>  ## actions
