From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fix wrong xhtml option to highlight
Date: Fri, 28 Jan 2011 13:35:40 +0100
Message-ID: <201101281335.41554.jnareb@gmail.com>
References: <1295898298-9794-1-git-send-email-Jochen@herr-schmitt.de> <1296092646.23506.10.camel@drew-northup.unet.maine.edu> <7vvd1agoii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>,
	Jochen Schmitt <Jochen@herr-schmitt.de>,
	Adam Tkac <atkac@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 13:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PinYO-0005IX-Hm
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 13:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab1A1Mfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 07:35:48 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46726 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab1A1Mfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 07:35:47 -0500
Received: by wwa36 with SMTP id 36so3301033wwa.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 04:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=D7w6odZk443Z9ohCQjtFlj25NL7yPgz+vGQssabds5I=;
        b=VNnkRIaLbqeLV04kMO44semcCO9PJTmaw6yJxJ0JiEgPX6kmFcQtfHvKJQg2fQFX6u
         qO+TA1kavkpjC5xPja4776Yt3fgbgz280yhyPY6RRrPjoIIlu8qjVwNCNYmElCeMrU9J
         9YZNKxkA6Tiw1FjgJKC6lSDMACzMEexfAMqPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hKyG5eTuy46a0i30aSDwZsYdts7KauAHWCl3qcA3M+DeIN2WdKp4T+HK664g8kuppP
         56v/vMVVHkEBF+HhLx/9SDNJrUKh3alpsWIrmiMrIZwjZi12TUMXl9LmDT2zCx8t/3rC
         srgQJeounfR2fo5EKe0IjvE1D8hGNCr5Q/QS0=
Received: by 10.227.143.11 with SMTP id s11mr2605155wbu.21.1296218145892;
        Fri, 28 Jan 2011 04:35:45 -0800 (PST)
Received: from [192.168.1.13] (abwe231.neoplus.adsl.tpnet.pl [83.8.228.231])
        by mx.google.com with ESMTPS id b30sm9005748wen.1.2011.01.28.04.35.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Jan 2011 04:35:44 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvd1agoii.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165615>

On Thu, 27 Jan 2011, Junio C Hamano wrote:
> Drew Northup <drew.northup@maine.edu> writes:
> 
>>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>>> index 1025c2f..b662420 100755
>>>> --- a/gitweb/gitweb.perl
>>>> +++ b/gitweb/gitweb.perl
>>>> @@ -3468,7 +3468,7 @@ sub run_highlighter {
>>>>  	close $fd;
>>>>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>>>>  	          quote_command($highlight_bin).
>>>> -	          " --xhtml --fragment --syntax $syntax |"
>>>> +	          " -xhtml --fragment --syntax $syntax |"
>>> 
>>> Curious.
>>> 
>>> Does the command take double-dash for the fragment and syntax options but
>>> a single dash for the xhtml option?  Really...
>>> 
>>> A few top hits returned by Google for "highlight manual page" tells me
>>> otherwise.
>>
>> Certainly appears to be the case that "--xhtml" is the option in Ubuntu
>> 10.04.1 LTS. 
>>
>> Jochen,
>> Did you mean "-X" (which sets the same option)?
> 
> The current proposal is to drop --xhtml and let highlight default to HTML.
> 
> Honestly speaking, I don't like the approach very much; it would have been
> much better if highlight had a single way that is supported throughout its
> versions to specify the output format.  But it appears that there isn't,
> and relying on and hoping for its default to stay HTML is the best we
> could do, if we plan to support highlight 2.4.something or older.
> 
> The copy of U10.04 I have has highlight 2.12, and according to its manual
> pages, -X, --xhtml, and --out-format=xhtml mean the same thing.  HTML is
> the default.
> 
> The change-log at www.andre-simon.de indicates that --out-format has
> become the preferred method and the short options like -X and -H are not
> supported in recent versions (3.0 beta and newer).
> 
> But as Jakub mentioned, 2.4.5 did not have --output-format; it was only in
> 3.0 beta that -O was redefined to mean --output-format and in old versions
> the short option meant something else.

Well, we can always require highlight >= 2.12, or whatever version
introduced --out-format option.

> 
> What a mess...
> 
> The next time we introduce a new dependency, we really should try hard to
> assess the stability and maturity of that dependency.  In hindsight, I
> think "highlight" was probably a bit too premature to be depended upon.

By the way, the idea was to make it possible to configure other highlighter,
but I went with what I known to work, i.e. with Andre Simon's "highlight". 
I think it could be fairly easy to make it configurable via existing
$highlight_bin and to be introduced @highlight_args gitweb configuration
variables.

There are three possible ways to do syntax highlighting in gitweb:
filter, Perl module, or via JavaScript.  An alternative to "highlight"
as a filter could be GNU source-highlight... if not for the fact that
it doesn't seem to support equivalent of "highlight" --fragment option,
i.e. exclude prolog and <pre><tt> wrappers.

-- 
Jakub Narebski
Poland
