From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 2/2] gitweb: append short hash ids to snapshot files
Date: Wed, 14 Oct 2009 01:46:40 +0200
Message-ID: <200910140146.42285.jnareb@gmail.com>
References: <4ABE536D.3070705@mailservices.uwaterloo.ca> <200910051206.18943.jnareb@gmail.com> <4AD34C93.20605@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Wed Oct 14 01:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxr9w-0003Uj-6l
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 01:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761628AbZJMXse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 19:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760728AbZJMXsd
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 19:48:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:61601 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760936AbZJMXsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 19:48:32 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1090902fga.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=78DXP9TKYpKp3VTVOFVPgY9QQlQR00Wbf6j580LygwU=;
        b=Y09cI88uGq1kRSwYW/HpskfIbmfhsdEaxzJ2294gCIYzlGQhpe1doolN/LLDwlWfhk
         /0Mg8Ya5VLDGInQgBynM0QT6Xrdru4wGyVyVnPtKAk+ZIgQS13jHBo0uKFWJWoz08mah
         cr2CMMiegWd+iTD7vhr7SwZkqGgKfJcN0/73E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=B4iBhgfiFJtMVgEqJlwAGkHVkUd4Gr4k9M0s+wgFoCcHS0vMGviaUQamiNQX09qtnH
         snZ4OzWFMBtlOQYk889hB2XMw1ZtFR1YqLTaIOnBl38BSI/auWroiuB35tLuoocugx53
         zSZTqhKwwrOIBWiBiLBGtoeqYwt2amW2f9CAA=
Received: by 10.86.238.30 with SMTP id l30mr3176321fgh.75.1255477604628;
        Tue, 13 Oct 2009 16:46:44 -0700 (PDT)
Received: from ?192.168.1.13? (abvb70.neoplus.adsl.tpnet.pl [83.8.199.70])
        by mx.google.com with ESMTPS id l12sm581277fgb.7.2009.10.13.16.46.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 16:46:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4AD34C93.20605@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130231>

On Mon, 12 Oct 2009, Mark Rada wrote:
> On 09-10-05 6:06 AM, Jakub Narebski wrote:
> 
>>>  	my $o_git_dir = $git_dir;
>>>  	my $retval = undef;
>>>  	$git_dir = "$projectroot/$project";
>>> -	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
>>> -		my $head = <$fd>;
>>> +	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--verify', $hash) {
>>> +		$hash = <$fd>;
>>>  		close $fd;
>>> -		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
>>> +		if (defined $hash && $hash =~ /^([0-9a-fA-F]{40})$/) {
>>> +			$retval = $1;
>>> +		}
>> 
>> I guess that you use "$retval = $1;" instead of just "$retval = $hash;"
>> because of similarities with git_get_short_hash, isn't it?  Or it is just
>> following earlier code?
> 
> Yeah, it is following earlier code, I did not change it, 

Ah, that's O.K.

Although if you plan refactoring this, you might fix this bit of
inefficiency (no need for capturing).

> though the diff seems to think I added it, perhaps this is a bug with
> diff? 

No, that is just diff being ambiguous, as there is more than one way
to generate diff of changes.  Perhaps patience diff would produce
better results, perhaps not.  It might mean that refactoring common
code is needed ;-)))))

>>> +	}
>>> +	if (defined $o_git_dir) {
>>> +		$git_dir = $o_git_dir;
>>> +	}
>>> +	return $retval;
>>> +}
>>> +
>>> +# try and get a shorter hash id
>>> +sub git_get_short_hash {
>>> +	my $project = shift;
>>> +	my $hash = shift;
>>> +	my $o_git_dir = $git_dir;
>>> +	my $retval = undef;
>>> +	$git_dir = "$projectroot/$project";
>>> +	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--short=7', $hash) {
>>> +		$hash = <$fd>;
>>> +		close $fd;
>>> +		if (defined $hash && $hash =~ /^([0-9a-fA-F]{7,})$/) {
>>>  			$retval = $1;
>>>  		}
>>>  	}
>> 
>> Note that git_get_full_hash (which additionally does verification) and
>> git_get_short_hash share much of code.  Perhaps it might be worth to
>> avoid code duplication somehow?  On the other hand it might be not worth
>> to complicate code by trying to extract common parts here...
> 
> Hmm, I think it might be a good idea to just write a generic routine
> that takes a hash length as an extra parameter. Then the short and full
> hash fetching routines can just acts as wrappers.

Well, git_get_full_hash uses --verify, git_get_short_hash uses --short=7
(but perhaps it should also use --verify).

BTW. I think that checking that output of git-rev-parse is (shortened)
SHA-1 predates usage of --verify; with --verify is, I think, not
necessary:

 --verify
     The parameter given must be usable as a single, valid object name.
     Otherwise barf and abort.

>>> @@ -5203,6 +5228,13 @@ sub git_snapshot {
>>>  		die_error(400, 'Object is not a tree-ish');
>>>  	}
>>>  
>>> +
>>> +	my $full_hash = git_get_full_hash($project, $hash);
>>> +	if ($full_hash =~ /^$hash/) {

BTW, we can use  

        if (index($full_hash, $hash) == 0) {

instead.  BTW, $hash could contain regexp metacharacters like '.'
('dead.beef' is a valid branch name), so it should be

	if ($full_hash =~ /^\Q$hash/) {

if you want to use regexp (it might be easier to read).  

Or you can encapsulate this into is_substring() subroutine, but that
might be (well, almost surely is) overkill...

>>> +		$hash = git_get_short_hash($project, $hash);
>>> +	} else {
>>> +		$hash .= '-' . git_get_short_hash($project, $hash);
>>> +	}
>> 
>> I think we might want to avoid calling git_get_full_hash (and extra call
>> to "git rev-parse" command, which is extra fork) if we know in advance
>> that  $full_hash =~ /^$hash/  can't be true, i.e. if $hash doesn't match
>> /^[0-9a-fA-F]+$/.  That would require that we continue to use $hash
>> and not $full_hash, see comment for the chunk below.
>> 
>> BTW do you think that having better name (nicer name in the case
>> when $hash is full SHA-1, or name which describes exact version as 
>> in the case when $hash is branch name or just 'HEAD') is worth
>> slight extra cost of "git rev-parse --abbrev=7"?
> 
> Hmm, yeah, some optimization will have to occur in that block of
> code. Though, my reason for that extra call to rev-parse to get the
> short hash is so I can get git to find the shortest unique SHA-1,
> instead of just assuming that it will always be of length 7. I think
> the cost is not too bad considering a snapshot will have to be generated
> and probably take way more time. Though, warthog9 has some caching
> patches that work, so maybe it isn't worth it. Hmm...

What I meant here that unless $hash =~ /^[0-9a-fA-F]{7,}$/ then we 
always use git_get_short_hash, as $full_hash wouldn't match /^$hash/
($hash wouldn't be a prefix of $full_hash).  We don't need to
calculate git_get_full_hash which wouldn't be used (see also comment
below, though).

> 
>>>  	my $name = $project;
>>>  	$name =~ s,([^/])/*\.git$,$1,;
>>>  	$name = basename($name);
>>> @@ -5213,7 +5245,7 @@ sub git_snapshot {
>>>  	$cmd = quote_command(
>>>  		git_cmd(), 'archive',
>>>  		"--format=$known_snapshot_formats{$format}{'format'}",
>>> -		"--prefix=$name/", $hash);
>>> +		"--prefix=$name/", $full_hash);
>> 
>> Why this change?
> 
> Since $hash can change by becoming something like 'HEAD-43ab5f2c' due to
> the process of creating the better name we need to pass something to
> `archive' that will be valid, and $full_hash will be valid.

Errr... why it is called _$hash_ then, if it can be not hash?  Wouldn't
it be better to manipulate $name here?

I think this fragment should be extracted into snapshot_name() subroutine,
which result would be used both as proposed snapshot name, and as prefix
to be used.

> 
>>> +test_description='gitweb as standalone script (parsing script output).
>>> +
>>> +This test runs gitweb (git web interface) as a CGI script from the
>>> +commandline, and checks that it produces the correct output, either
>>> +in the HTTP header or the actual script output.'
>> 
>> Currently all tests here are about 'snapshot' action.  They are quite
>> specific, and they do require some knowledge about chosen archive format.

That is not true, as I haven't noticed at this point that you are 
examining only HTTP headers... but not the HTTP status but other headers.

[...]
>>> +	grep ".git-$ID.tar.gz" gitweb.output
>> 
>> Here had to think a bit that gitweb.output consists both of HTTP headers,
>> and of response body, and you are grepping here in the HTTP headers part.
>> It would be better solution for gitweb_run to split gitweb.output into
>> gitweb.headers and gitweb.body (perhaps if requested by setting some
>> variable, e.g. GITWEB_SPLIT_OUTPUT).
>> 
>> It can be done using the following lines:
>> 
>> 	sed    -e '/^\r$/'      <gitweb.output>gitweb.headers

That was meant to be

>> 	sed    -e '/^\r$/q'     <gitweb.output >gitweb.headers

which means print (the default action) until single empty CRLF terminated
line, which ends HTTP headers.

>> 	sed -n -e '0,/^\r$/!p'  <gitweb.output>gitweb.body
>> 
>> 	# gitweb.headers is used to parse http headers
>> 	# gitweb.body is response without http headers
>> 
>> But the second one uses GNU sed extension; I don't know how to write
>> it in more portable way.
> 
> I like this and will try to find a way of setting this up without using
> GNU extensions.

Well, we do know that there always would be at least one header, so we
can use:

 	sed -n -e '1,/^\r$/!p'  <gitweb.output >gitweb.body

But I'd prefer that somebody better versed in sed would come up with
solution to extract everything up to first empty CRLF terminated line,
and everything from such line till the end of file.

>> Note that to avoid ambiguities currently gitweb uses refs/heads/master
>> and refs/tags/SnapshotFileTests... but dealing with this issue should be
>> left, I think, for separate commit.
>> 
> 
> I do not understand what ambiguity exists, can you please explain this?

The problem I was thinking about is the following.

In commit bf901f8 (gitweb: disambiguate heads and tags withs the same
name, 2007-12-15) started to use refs/heads/<branch> and refs/tags/<tag>
instead of <branch> and <tag> because there was problem when there were
tag and branch with the same name.

The problem is that we can't use '/' in proposed snapshot file name,
and we shouldn't use '/' in git-archive prefix.  So we can't simply
use (as you proposed) 

  $hash . '-' . git_get_short_hash($project, $hash);

as a snapshot basename suffix, because $hash can be 'refs/heads/master',
or it can be 'mr/gitweb-snapshot'.  What to do, what to do...


Also if $hash is refs/tags/v1.6.0, we don't really need shortened SHA-1
suffix.  

Alternative to checking for refs/tags/ prefix would be to use
git-describe output... perhaps.

-- 
Jakub Narebski
Poland
