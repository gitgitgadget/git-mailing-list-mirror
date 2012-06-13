From: volekp <volekp@telesun.imag.fr>
Subject: Re: [PATCHv3 1/2] git-remote-mediawiki: import "File:" attachments
Date: Wed, 13 Jun 2012 15:37:52 +0200
Message-ID: <afdeb82809f49f34073d7b57260edee9@telesun.imag.fr>
References: <1339532091-25232-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
 <7vy5nsi6lq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pavel Volek <Pavel.Volek@ensimag.imag.fr>, <git@vger.kernel.org>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 15:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Senlu-0008Op-MU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 15:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab2FMNh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 09:37:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46013 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415Ab2FMNh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 09:37:59 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5DDSgTo028889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jun 2012 15:28:42 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5DDbrWL011908;
	Wed, 13 Jun 2012 15:37:53 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q5DDbrEq000828;
	Wed, 13 Jun 2012 15:37:53 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q5DDbqYf000827;
	Wed, 13 Jun 2012 15:37:52 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to volekp@telesun.imag.fr using -f
In-Reply-To: <7vy5nsi6lq.fsf@alter.siamese.dyndns.org>
X-Sender: volekp@telesun.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 Jun 2012 15:28:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5DDSgTo028889
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: volekp@telesun.imag.fr
MailScanner-NULL-Check: 1340198923.19503@KD8ruY1KB7D9rRfHNGgDuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199890>

On Tue, 12 Jun 2012 14:05:21 -0700, Junio C Hamano wrote:
> Pavel Volek <Pavel.Volek@ensimag.imag.fr> writes:
>
>> From: Pavel VOlek <Pavel.Volek@ensimag.imag.fr>
>
> Did you really mean this?  It does not match your S-o-b: line below.

You're right, I will change it.

>>
>> The current version of the git-remote-mediawiki supports only import 
>> and export
>> of the pages, doesn't support import and export of file attachments 
>> which are
>> also exposed by MediaWiki API. This patch adds the functionality to 
>> import file
>> attachments and description pages for these files.
>>
>> Chages version2 -> version3:
>> Fixes in comments.
>> Variable '$file' -> '$file_content' refactoring to be clearer.
>
> These three lines do not belong here above the three-dash lines, I 
> think.

OK. But should I mention somewhere the changes I performed from the 
precedent to
the actual version of the PATCH?

>> @@ -71,6 +68,9 @@ chomp(@tracked_pages);
>>  my @tracked_categories = split(/[ \n]/, run_git("config --get-all 
>> remote.". $remotename .".categories"));
>>  chomp(@tracked_categories);
>>
>> +# Import media files too.
>> +my $import_media = run_git("config --get --bool remote.". 
>> $remotename .".mediaimport");
>> +
>>  my $wiki_login = run_git("config --get remote.". $remotename 
>> .".mwLogin");
>>  # TODO: ideally, this should be able to read from keyboard, but 
>> we're
>>  # inside a remote helper, so our stdin is connect to git, not to a
>> @@ -225,6 +225,10 @@ sub get_mw_pages {
>>  			get_mw_first_pages(\@slice, \%pages);
>>  			@some_pages = @some_pages[51..$#some_pages];
>>  		}
>> +
>> +		if ($import_media) {
>> +			get_mw_pages_for_linked_mediafiles(\@tracked_pages, \%pages);
>> +		}
>
> I am guessing that the loop above is to avoid fetching and
> processing too many pages at once.  Doesn't the call to
> get_mw_pages_for_linked_mediafiles() need a similar consideration,
> or what the function does is significantly different from what
> get_mw_first_pages() does and there is no need to worry?
>
> By the way, does it really have to be that overly long name?

Yes, it will be better to split the processing in a similar way. Now 
there is
a possibility that because of the MW limits, we won't get all media 
files.

For the name of the method I wanted to be precise and clear, I didn't 
find
more fitting name. Any suggestions welcomed.

>> @@ -244,6 +248,11 @@ sub get_mw_pages {
>>  			foreach my $page (@{$mw_pages}) {
>>  				$pages{$page->{title}} = $page;
>>  			}
>> +
>> +			if ($import_media) {
>> +				my @titles = map $_->{title}, @{$mw_pages};
>> +				get_mw_pages_for_linked_mediafiles(\@titles, \%pages);
>> +			}
>>  		}
>>  	}
>>  	if (!$user_defined) {
>> @@ -263,10 +272,186 @@ sub get_mw_pages {
>>  		foreach my $page (@{$mw_pages}) {
>>  			$pages{$page->{title}} = $page;
>>  		}
>> +
>> +		if ($import_media) {
>> +			# Attach list of all pages for media files from the API,
>> +			# they are in a different namespace, only one namespace
>> +			# can be queried at the same moment
>> +			my $mw_pages = $mediawiki->list({
>> +				action => 'query',
>> +				list => 'allpages',
>> +				apnamespace => get_mw_namespace_id("File"),
>> +				aplimit => 500
>> +			});
>> +			if (!defined($mw_pages)) {
>> +				print STDERR "fatal: could not get the list of pages for media 
>> files.\n";
>> +				print STDERR "fatal: '$url' does not appear to be a 
>> mediawiki\n";
>> +				print STDERR "fatal: make sure '$url/api.php' is a valid 
>> page.\n";
>> +				exit 1;
>> +			}
>> +			foreach my $page (@{$mw_pages}) {
>> +				$pages{$page->{title}} = $page;
>> +			}
>> +		}
>
> For categories you need to call pages-for-mediafiles with the titles
> you learned (the hunk starting at l.224), but there is no need to
> call pages-for-mediafiles in this hunk?

Actually it is not necessary. In here the user doesn't specify the 
pages or
categories to be imported, so the whole wiki is imported. Thats why we 
can
skip the searching for relations between pages and files and directly 
ask
for all files.

>> +sub get_mw_pages_for_linked_mediafiles {
>> +	my $titles = shift;
>> +	my @titles = @{$titles};
>
> Do you really need to make a copy of this array?  Wouldn't it
> suffice to say
>
> 	my $mw_titles = join('|', @$titles);
>
> at the only location in this function that uses this parameter?

You are right, I will change it.

>> +	my $pages = shift;
>> +
>> +	# pattern 'page1|page2|...' required by the API
>> +	my $mw_titles = join('|', @titles);
>
> Nobody seems to be making sure there won't be more than 500 (I am
> assuming that this script is considered a 'bot) pages in $mw_titles
> variable.  Shouldn't the API call be split into such batches?

Right, it would be better.

>> +	# Media files could be included or linked from
>> +	# a page, get all related
>> +	my $query = {
>> +		action => 'query',
>> +		prop => 'links|images',
>> +		titles => $mw_titles,
>> +		plnamespace => get_mw_namespace_id("File"),
>> +		pllimit => 500
>> +	};
>> +	my $result = $mediawiki->api($query);
>> +
>
>
>> +
>> +# Return MediaWiki id for a canonical namespace name.
>> +# Ex.: "File", "Project".
>> +# Looks for the namespace id in the local configuration
>> +# variables, if it is not found asks MW API.
>> +sub get_mw_namespace_id {
>> +	mw_connect_maybe();
>> +
>> +	my $name = shift;
>> +
>> +	# Look at configuration file, if the record
>> +	# for that namespace is already stored.
>> +	# Namespaces are stored in form: "Name_of_namespace:Id_namespace",
>> +	# Ex.: "File:6".
>> +	my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all 
>> remote.". $remotename .".namespaces"));
>> +	chomp(@tracked_namespaces);
>> +	if (@tracked_namespaces) {
>> +		foreach my $ns (@tracked_namespaces) {
>> +			my @ns_split = split(/:/, $ns);
>> +			if ($ns_split[0] eq $name) {
>> +				return $ns_split[1];
>> +			}
>> +		}
>> +	}
>
> Does it make sense to call out to run_git() every time this function
> is called?  Shoudln't this part be caching the result in a hash,
> something like
>
> 	if (!exists $namespace_id{$name}) {
> 		@temp = ... run_git() ...;
>                 foreach my $ns (@temp) {
> 			my ($n, $s) = split(/:/, $ns);
> 			$namespace_id{$n} = $s;
> 		}
> 	}
>
> 	if (!exists $namespace_id{$name}) {
> 		... similarly, ask MW API and store in %namespace_id{}
> 	}
>
>         if (exists $namespace_id{$name}) {
>         	return $namespace_id{$name};
> 	}
> 	die "No such namespace $name";

Good idea, I will look closer on it!

Thanks for your review!
