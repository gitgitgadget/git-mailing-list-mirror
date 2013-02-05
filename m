From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 14:24:01 -0800
Message-ID: <7vip66qu0u.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
 <87ehgvua6h.fsf@lifelogs.com> <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <7vhalqsfkf.fsf@alter.siamese.dyndns.org>
 <8738xaqy40.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:24:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2qwK-00052N-OW
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 23:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab3BEWYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 17:24:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964Ab3BEWYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 17:24:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AD22BF2B;
	Tue,  5 Feb 2013 17:24:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HcmqR7nxlnLWG1Znz1eu1m9xSTs=; b=Msy01h
	IoX2AQbYbWoOkLg4L73VCPg4rar8Mfsjylxr7PcYfJrNvvpaKYTfQzAzCQfGVJoi
	MDcwbK83h+xhxLZsupnSr7TiUgmId3gg/6nD/9iTTxd+IfzcbhTgnyT1NphFsuLh
	ABUEOVG5cFEGIltBFFQz0RnQnzu8kf/E+GhgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QU5+TTGaqFnvvI0/BblnG/1HR6Ecadfj
	SQKYFm9Ug/pBabIZ5agePJpa5xskCX4DamCOX5NEsvgMvrUb01KQtmcdv7clt/Oa
	teZFYLjkVLQgv130Jq5LVOIvsqdWAOhytx8pc6bPQnPBCwE5QgPpLyrjy1LBx457
	o6ciOz4DQN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7A75BF28;
	Tue,  5 Feb 2013 17:24:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56207BF23; Tue,  5 Feb 2013
 17:24:03 -0500 (EST)
In-Reply-To: <8738xaqy40.fsf_-_@lifelogs.com> (Ted Zlatanov's message of
 "Tue, 05 Feb 2013 15:55:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF2999C4-6FE2-11E2-9806-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215545>

Ted Zlatanov <tzz@lifelogs.com> writes:

> +	unless (scalar @entries) {
> +		if ($!) {
> +			log_verbose("Unable to open $file: $!");
> +		}
> +		else {

	} else {

> +			log_verbose("No netrc entries found in $file");
> +		}
> +
> +	if ($gpgmode) {
> +		# typical shell character escapes from http://www.slac.stanford.edu/slac/www/resource/how-to-use/cgi-rexx/cgi-esc.html
> +		my $f = $file;
> +		$f =~ s/([;<>\*\|`&\$!#\(\)\[\]\{\}:'"])/\\$1/g;

Yuck.  If you really have to quote, it is often far simpler to take
advantage of the fact that quoting rule for shell is much simpler
inside '', i.e.

	sub sq {
		my ($string) = @_;
		$string =~ s|'|'\\''|g;
		return "'$string'";
	}

The only thing you have to worry about is a single quote, which
would close the single quote you want to be in, and you express it
by first closing the single quote you opened, put the single quote
by emitting a backslash and a single quote, and then immediately 
open another single quote.

> +		# GPG doesn't work well with 2- or 3-argument open

I think I commented on this in a separate message.

> +	# Net::Netrc does this, but the functionality is merged with the file
> +	# detection logic, so we have to extract just the part we need
> +	my @netrc_entries = net_netrc_loader($io);
> +
> +	# these entries will use the credential helper protocol token names
> +	my @entries;
> +
> +	foreach my $nentry (@netrc_entries) {
> +		my %entry;
> +		my $num_port;
> +
> +		if (defined $nentry->{port} && $nentry->{port} =~ m/^\d+$/) {
> +			$num_port = $nentry->{port};
> +			delete $nentry->{port};
> +		}
> +
> +		# create the new entry for the credential helper protocol
> +		$entry{$options{tmap}->{$_}} = $nentry->{$_} foreach keys %$nentry;
> +
> +		# for "host X port Y" where Y is an integer (captured by
> +		# $num_port above), set the host to "X:Y"
> +		if (defined $entry{host} && defined $num_port) {
> +			$entry{host} = join(':', $entry{host}, $num_port);
> +		}
> +
> +		push @entries, \%entry;
> +	}
> +
> +	return @entries;
> +}

I'll leave this part to Peff to comment on.

> +sub net_netrc_loader {
> +	my $fh = shift @_;
> +	my @entries;
> +	my ($mach, $macdef, $tok, @tok);
> +
> +    LINE:
> +	while (<$fh>) {
> +		undef $macdef if /\A\n\Z/;
> +
> +		if ($macdef) {
> +			next LINE;
> +		}
> +
> +		s/^\s*//;
> +		chomp;
> +
> +		while (length && s/^("((?:[^"]+|\\.)*)"|((?:[^\\\s]+|\\.)*))\s*//) {
> +			(my $tok = $+) =~ s/\\(.)/$1/g;
> +			push(@tok, $tok);
> +		}
> +
> +	    TOKEN:
> +		while (@tok) {
> +			if ($tok[0] eq "default") {
> +				shift(@tok);
> +				undef $mach; # ignore 'default' lines

I think it is saner to do something like this instead here:

				$mach = { machine => undef }

Otherwise your log_debug() will be filled by the tokens used for the
default entry, and also this "undef $mach" here will break your
macdef skipping logic if the default entry has a macdef, I think.

You can ignore an entry with undefined "machine" in the loop at the
end of load_netrc.

> +				next TOKEN;
> +			}
> +
> +			$tok = shift(@tok);
> +
> +			if ($tok eq "machine") {
> +				my $host = shift @tok;
> +				$mach = { machine => $host };
> +				push @entries, $mach;
> +			}
> +			elsif (exists $options{tmap}->{$tok}) {
> +				unless ($mach) {
> +					log_debug("Skipping token $tok because no machine was given");
> +					next TOKEN;
> +				}
> +
> +				my $value = shift @tok;
> +				unless (defined $value) {
> +					log_debug("Token $tok had no value, skipping it.");
> +					next TOKEN;
> +				}
> +
> +				# Following line added by rmerrell to remove '/' escape char in .netrc
> +				$value =~ s/\/\\/\\/g;
> +				$mach->{$tok} = $value;
> +			}
> +			elsif ($tok eq "macdef") { # we ignore macros
> +				next TOKEN unless $mach;
> +				my $value = shift @tok;
> +				$macdef = 1;
> +			}
> +		}
> +	}
> +
> +	return @entries;
> +}
> +
> +sub read_credential_data_from_stdin {
> +	# the query: start with every token with no value
> +	my %q = map { $_ => undef } values(%{$options{tmap}});
> +
> +	while (<STDIN>) {
> +		next unless m/^([^=]+)=(.+)/;
> +
> +		my ($token, $value) = ($1, $2);
> +		die "Unknown search token $token" unless exists $q{$token};
> +		$q{$token} = $value;
> +		log_debug("We were given search token $token and value $value");
> +	}
> +
> +	foreach (sort keys %q) {
> +		log_debug("Searching for %s = %s", $_, $q{$_} || '(any value)');
> +	}
> +
> +	return \%q;
> +}
> +
> +# takes the search tokens and then a list of entries
> +# each entry is a hash reference
> +sub find_netrc_entry {
> +	my $query = shift @_;
> +
> +    ENTRY:
> +	foreach my $entry (@_)
> +	{
> +		my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
> +		foreach my $check (sort keys %$query) {
> +			if (defined $query->{$check}) {
> +				log_debug("compare %s [%s] to [%s] (entry: %s)",
> +					  $check,
> +					  $entry->{$check},
> +					  $query->{$check},
> +					  $entry_text);
> +				unless ($query->{$check} eq $entry->{$check}) {
> +					next ENTRY;
> +				}
> +			}
> +			else {
> +				log_debug("OK: any value satisfies check $check");
> +			}
> +		}
> +
> +		return $entry;
> +	}
> +
> +	# nothing was found
> +	return;
> +}

I'll leave this part to Peff to comment on.

> +
> +sub print_credential_data {
> +	my $entry = shift @_;
> +	my $query = shift @_;
> +
> +	log_debug("entry has passed all the search checks");
> + TOKEN:
> +	foreach my $git_token (sort keys %$entry) {
> +		log_debug("looking for useful token $git_token");
> +		# don't print unknown (to the credential helper protocol) tokens
> +		next TOKEN unless exists $query->{$git_token};
> +
> +		# don't print things asked in the query (the entry matches them)
> +		next TOKEN if defined $query->{$git_token};
> +
> +		log_debug("FOUND: $git_token=$entry->{$git_token}");
> +		printf "%s=%s\n", $git_token, $entry->{$git_token};
> +	}
> +}
> +sub log_verbose {
> +	return unless $options{verbose};
> +	printf STDERR @_;
> +	printf STDERR "\n";
> +}
> +
> +sub log_debug {
> +	return unless $options{debug};
> +	printf STDERR @_;
> +	printf STDERR "\n";
> +}

Otherwise, looks almost ready to me.

Thanks.
