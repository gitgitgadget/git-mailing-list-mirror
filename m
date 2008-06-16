From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Tue, 17 Jun 2008 01:37:55 +0200
Message-ID: <200806170137.56263.jnareb@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <m37icqpb5f.fsf@localhost.localdomain> <48568D5C.5090909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 01:39:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8OI8-00026o-AY
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 01:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022AbYFPXiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 19:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756864AbYFPXiW
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 19:38:22 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:37399 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525AbYFPXiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 19:38:20 -0400
Received: by ik-out-1112.google.com with SMTP id c28so4329517ika.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 16:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=y0XIZZ+ugzdG9v7ONiBz1t9oDz1ox3YoxNc5r+Ct/04=;
        b=S33F1v3mb2Ov5h8naQFaZnjqqmsFAP8lv97PDjjMmx0eo9ugTfHiRlHnD2FVmpceBK
         yhnBd+n62zsIWTixR0XTpF32CypMe79n1i8s6LCh5IcXc8GLCv5FBpjYRLHRkM7ddh43
         6aJIZ3Q0JC2a1dcqLW960gbZk0Pw9n+Xfimoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CdwwZH4BzMl1t0YhPgO/wK4ITPZsJLj7UqmpVygQqLsixo5VqzW9m4xrzNXQ9wuFYe
         Qgz4JwNWHnuDcC61w4AsSk/702I7bIHfBBO98Trh/159tj/ZhIniKLVMcjoq9uhc/SKE
         E8JSQY4QyT6WmItdgYqR7bpFiLx3VCwjDf3VY=
Received: by 10.210.11.13 with SMTP id 13mr6751161ebk.142.1213659498478;
        Mon, 16 Jun 2008 16:38:18 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.236.117])
        by mx.google.com with ESMTPS id z33sm9460729ikz.0.2008.06.16.16.38.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 16:38:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48568D5C.5090909@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85248>

On Mon, 16 Jun 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
>> 
>> I'd like to have reasoning when, and why, we use which responses (HTTP
>> status codes) in which situations.  Link to appropriate RFC you used
>> (and perhaps to some other information)
> 
> RFC 2616 has clear descriptions of the codes we use.

The RFC number was not mentioned in commit message, if I remember
correctly. URL like http://tools.ietf.org/html/rfc2616 would also
be nice (especially when/if gitweb finally acquires committags
support).

> Maybe a really short list of conventions though, like you listed
> below? 

That would be nice.

Perhaps it should be organized differently, i.e. start with different
HTTP error status codes, and when they are used (situations), and not
with categories of situations and poposed HTTP codes.

> If we have agreement I'll happily put it in.

Even if there is no agreement, it is something that can be discussed
when talking about given patch sent.

>>> For convenience the die_error function now only takes the status code
>>> without reason as first parameter
>> 
>> Well, gitweb sometimes used different wording
> 
> The 'reason' only appeared in the HTTP response header -- see below.

I'd rather have explanation in HTTP resonse header, not only pure
number.  For example Test::WWW::Mechanize::CGI shows both code
and _description_ when there is error (for get_ok).
 
>>>  	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
>>> -		or die_error(undef, "Open git-ls-tree failed");
>>> +		or die_error(500, "Open git-ls-tree failed");
>> 
>> Should we really use "500 Internal Server Error" here?  Usually this
>> would be not an error at all, but wrong parameters to git command,
>> i.e. it is _user_ who erred, not some error on _server_ side.
> 
> You cannot tell for sure -- all you know here is that the command
> somehow failed when it shouldn't have, and so all you can give is 500;
> see below.  I don't think we should apply reasoning like "most commonly
> it's a wrong hash, so let's return 404" -- we don't know, and we
> shouldn't assume.

I think that in this situation, "open or die_error(...)", if error can
happen at all, it can happen only because of some serious error, like
git not installed[*1*], or corrupted repository, or something.

We would have to examine "close or die_error(...)" to check (perhaps
like Junio proposed examining details in a slow path, perhaps catching
and examining Error from Git.pm methods, perhaps examining stderr)
whether this is user error with 4xx HTTP status code, or server error
with 5xx HTTP status code.
 

[*1*] Perhaps we should have upfront in gitweb something like

  unless (-x "$GIT")
  	die_error("500 Internal Server Error", 'Git binary not found');

or something like that.  Here it is _server_ error, and you should mail
webmaster / web page admin, and not examine your URL as in case of
_user_ error of 4xx variety.

>>> ... I suspect that the error could be triggered by non-existent hashes
>>> as well, in which case the more specific 404 would be more appropriate
>>> -- however, the current implementation oftentimes doesn't allow for
>>> more fine-granulared checking
>> 
>> ...that is why I'd rather have "403 Forbidden" as catch-all error, as
>> it was done in gitweb.  But that also seems not very good idea.
> 
> [IANA HTTP expert, but:] All we have in cases like the one above is "I
> cannot deliver the content you requested, but I'm so confused that I
> don't even know why" -- which sounds like 500 to me (definitely not
> 403).  403 would be used for some deactivated feature (commonly for
> disabled directory listings I think) or something that shouldn't be
> accessible to the public.

I think that "404 Not Found" would be better catch-all than
"500 Internal Server Error"... unless we are sure or almost sure that
it _is_ server error.
 
>>>  sub die_error {
>>> -	my $status = shift || "403 Forbidden";
>>> -	my $error = shift || "Malformed query, file missing or permission denied";
>>> +	my $status = shift || 500;
>>> +	my $error = shift || "Internal server error";
>> 
>> Errr, I think "Malformed query, file missing or permission denied" is
>> actually closer to truth,  and better error message
> 
> This default is intended for expressions like "some_action(...) or
> die_error" (without parameters), in which case you really can't tell
> what triggered the error, so "Internal server error" is as specific as
> you can get.

I think that most errors are of the above... but I guess that it is
a moot point, because even if status sometimes is taken default,
I don't think there is callsite that makes use of default for $error,
i.e. second argument of die_error() is always set explicitely.
 
>> (it is displayed in body of message)
> 
> Just to make sure we're on the same boat, the $error variable above *is*
> what's displayed in the body.

True.
 
>>> +	# Use a generic "Error" reason, e.g. "404 Error" instead of
>>> +	# "404 Not Found".  This is permissible by RFC 2616.
>>> +	git_header_html("$status Error");
>> 
>> I don't think it is _recommended_ practice.  IIRC it is recommnded
>> [...] to give more detailed explanation in the body of message.
> 
> The code above prints the HTTP response headers, not the body -- the
> body contains the detailed error message passed to the die_error
> function.  Here's a stripped down version of gitweb's error response 
> (X'ed out against spam filter):
> 
> HTXTP/1.0 404 Error   <------------ "Error" here
> CoXntent-Type: text/htXml
> 
> ... 404 - Hash not found ...
> 
> I don't know of *any* browser or tool that actually displays the reason
> given in the HTTP response header, so defaulting to Error is fine here

Test::WWW::Mechanize displays both numeric HTTP response *and* reason
given in HTTP response header when get_ok(...) fails.
 
Besides we would want some explanation also on HEAD reuests (supported
now only for web feeds, IIRC).

> (especially since RFC 2616 explicitly allow it).

Could you point me to where it is?  And no, I don't think that 
"The reason phrases listed here are only  recommendations -- they MAY
 be replaced by local equivalents without affecting the protocol." 
is it.

> (I don't want to put the $error passed to die_error into the HTTP
> response header, since badly interpolated strings might invalidate the
> response.  So using "Error" makes sure we always die gracefully.)

Errr... I think we can trust gitweb programmers to not screw up.
Perhaps there should be comment that first argument should be plain
text, while second can be HTML fragment.
 

>> Proposed HTTP server/client error status codes [heavily snipped]:

Let us put it in different order.

1. 4xx: Client Error - The request contains bad syntax or cannot
        be fulfilled

1.1. 400 Bad Request - The request could not be understood by the
         server due to malformed syntax.
 
     Here I think we should put all the cases where we know that URL
     is invalid even without examining any data, after purely
     syntaxical checking.  This means params with values outside their
     domain, like for example $page ('pg') parameter which is not
     a number.

     It *might* be also used for some unreasonable discrepancies
     in parameters which need access to git repository to check, like
     asking for blame view of non-blob... although this could also be
     "404 Not Found".


1.2. 403 Forbidden - The server understood the request, but is refusing
         to fulfill it.   Authorization will not help (...)

     (Sometimes as "403 Permission Denied").

     Here I think we should put all the cases where access is denied
     because of gitweb or repo configuration; this I think does not
     include non-exported projects.  This usually means some 'feature'
     disabled (not enabled).

1.3. 404 Not Found - The server has not found anything matching the
         Request-URI. No indication is given of whether the condition
         is temporary or permanent. (...) This status code is commonly
         used when the server does not wish to reveal exactly why the
         request has been refused, or when no other response is
         applicable.

     Here we should put all the situations where we ask for commit, and
     does not get it, as for a project, and such project does not exist,
     ask for a path, and there is no such path in specified tree-ish,
     asking for a tag while there is nothing under given name, etc.

     It could also be a reasonable catch-all.


2. 5xx: Server Error - The server failed to fulfill an apparently
        valid request

2.1. 500 Internal Server Error - The server encountered an unexpected
         condition which prevented it from fulfilling the request.

     Here I think we can put problems with git binaries, corrupted
     repositories, some Perl error etc.  Something you should mail
     webmaster (web admin) about.

     All "open or die_error(...)" should I guess go there, although
     I'm not sure when/if that can happen.   About "close or die...":
     those ones would need carefull examination if they should result
     in 404 or in 500 error code zone.

2.2. 503 Service Unavailable - The server is currently unable to handle
         the request due to a temporary overloading or maintenance of
         the server. The implication is that this is a temporary
         condition which will be alleviated after some delay.

     Perhaps during longer regenerating cache this should be
     response...

-- 
Jakub Narebski
ShadeHawk on #git
Poland
