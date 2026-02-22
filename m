Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580DCA6F
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771774687; cv=none; b=ItfH0zGpUpbuarMkwNlyijchS+aTcWuDBBEiLPHOejnoHjuw5ll3YhnLscdSlQQO7U0KJeOe+XPVPuDf+UVHarQUfqfclJil7oiUAaCADhoa1TFMysgxK4PUZQx6Rhwq1tw6oZOvnh2B1Oxj88SCbIXIfrpag7qYSwQWspyFDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771774687; c=relaxed/simple;
	bh=49NQqS57ylBqIb2dFPnzowgEjbiRK8IAZkr000/nhvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rE/6OW2lhXBr0YdQ6vaygr8lDefS6y45H7pfp2NyYQOn2tLZxg739rHGq2xt+QWJKhUHVb7Bag4oN5bsqqmN+PJt4LJGO3yn2Q7VGMN7M5SIDTDvsH3CDSquRhJqYxdJvoGhhZ2Pyk+QirOato399NhrLc/Yyb+cH7nsfV/RPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email; spf=pass smtp.mailfrom=iee.email; dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b=h/63/2O0; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iee.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="h/63/2O0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2025082600; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=XSDcbOYR+4WIyVvnpQNFXWqTqP/4dwTJ2vL9xe8KgcE=; b=h/63/2
	O0hiiweDv8MqNI7U3UDzNFT9hDju8Bacv2H5EPC5WMmef1ad52aN0/9Z/26Yx5xKKdTrfA9pBys5z
	RupELYDZrYwzsfsbdB9Pux69rARXNJDFQhCNujrAAZ4NPxb8HYTKDCtp4DrPygX8HjhV6xsjmEfuI
	HeQidZE1kFM=;
Received: from host-80-45-41-55.as13285.net ([80.45.41.55] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1vuApx-0000000HLY0-1acA;
	Sun, 22 Feb 2026 14:53:33 +0000
Message-ID: <335b1189-f5c3-4e7c-ad3a-266810a0ca90@iee.email>
Date: Sun, 22 Feb 2026 14:53:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: ben.knoble@gmail.com, gitster@pobox.com
References: <xmqqldgmrom9.fsf@gitster.g>
 <20260222140737.1760413-1-shreyanshpaliwalcmsmn@gmail.com>
From: Philip Oakley <philipoakley@iee.email>
Content-Language: en-GB
In-Reply-To: <20260222140737.1760413-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2026 14:03, Shreyansh Paliwal wrote:
>>> That makes sense, I tried it below.
>>> I also wondered whether, in addition to this, it might be helpful to warn on
>>> an invalid charset, and/or possibly fall back to UTF-8.
>>
>> Agreed on the first half of the statement, if we have an easy and
>> portable way to tell if a given random string names a valid charset.
>> I do not recommend to "fall back" to anything, if we are asking an
>> input from the user.
> 
> Following up on this, I tried adding a warning when the provided charset
> does not appear to be valid. Current flow is,
> 
>   Which 8bit encoding should I declare [UTF-8]? y

Perhaps swap around the 'Which-declare' to "Declare which' to to get
away from the obviousness of 'Which' being the classic y/n binary
question. Action first?

	Declare which 8bit encoding to use [default:UTF-8]?

Checking validity of the encoding is a reasonable follow on.

Philip

>   Are you sure you want to use <y> [y/N]? y
> 
> With the additional check, it becomes,
> 
>   Which 8bit encoding should I declare [default: UTF-8]? y
>   warning: 'y' does not appear to be a valid charset name.
>   Are you sure you want to use <y> [y/N]?
> 
> This uses find_encoding() from Perl’s Encode module to detect any
> unrecognized charset names.
> 
> Let me know what you think.
> Also, is there any new test that should be added for this change?
> 
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  git-send-email.perl | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index cd4b316ddc..e62fa259ba 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -23,6 +23,7 @@
>  use Git::LoadCPAN::Error qw(:try);
>  use Git;
>  use Git::I18N;
> +use Encode qw(find_encoding);
>  
>  Getopt::Long::Configure qw/ pass_through /;
>  
> @@ -1044,9 +1045,25 @@ sub file_declares_8bit_cte {
>  	foreach my $f (sort keys %broken_encoding) {
>  		print "    $f\n";
>  	}
> -	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
> -				  valid_re => qr/.{4}/, confirm_only => 1,
> -				  default => "UTF-8");
> +	while (1) {
> +		my $encoding = ask(__("Which 8bit encoding should I declare [default: UTF-8]? "),
> +			valid_re => qr/^\S+$/,
> +			default  => "UTF-8");
> +		next unless defined $encoding;
> +		if (find_encoding($encoding)) {
> +			$auto_8bit_encoding = $encoding;
> +			last;
> +		}
> +		printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
> +		my $yesno = ask(
> +			sprintf(__("Are you sure you want to use <%s> [y/N]? "), $encoding),
> +			valid_re => qr/^(?:y|n)/i,
> +			default  => 'n');
> +		if (defined $yesno && $yesno =~ /^y/i) {
> +			$auto_8bit_encoding = $encoding;
> +			last;
> +		}
> +	}
>  }
>  
>  if (!$force) {

