From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] More diff possibilities in gitweb
Date: Mon, 19 Mar 2007 00:20:55 +0100
Message-ID: <200703190020.55806.jnareb@gmail.com>
References: <20070317151731.GA32571@auto.tuwien.ac.at> <Pine.LNX.4.63.0703171902200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070318141451.GA9607@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:21:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT4gV-0001wS-HE
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 00:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933405AbXCRXVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 19:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933228AbXCRXVD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 19:21:03 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:13310 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933405AbXCRXVB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 19:21:01 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1554591muf
        for <git@vger.kernel.org>; Sun, 18 Mar 2007 16:20:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uj69EXPTDdi6Ycm5kM1do5L2FXIKnq1j/VDsx8vUUOznQoNIR1w7NT1+7ZQ7hjA7YUhaxNNxTQBCf0ETL1cbweWJfUeoo5fvdZlPt30cp0jJ/dQodlCoO37/Q3+SlbpSqy8CIPaVmoe8vr5gq7pN/cuwHWr51VYkEHXdjV9T9lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ay+raDi/Ah6EV5sL1UsDKUOOLqN2wcNDNrd4y/9YJkk8J9SGmakFDeslgvOotFR+pdn1CfZwu8wzTI0sDli294eE0bzywhL+nyvNEBZH8fKGCi/uYABGCHCCZIXNvsqFGdzupVu629bm0iOcDfXbsqpuLvlX/nERzEJqi9wXL6E=
Received: by 10.82.114.3 with SMTP id m3mr8803181buc.1174260059124;
        Sun, 18 Mar 2007 16:20:59 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g8sm16173792muf.2007.03.18.16.20.56;
        Sun, 18 Mar 2007 16:20:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070318141451.GA9607@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42542>

Some of discussion is repeated in another subthread

On Sun, Mar 18, 2007, Martin Koegler wrote:
> On Sat, Mar 17, 2007 at 07:04:54PM +0100, Johannes Schindelin wrote:
>> On Sat, 17 Mar 2007, Martin Koegler wrote:
>> 
>>> The whole is implemented in JavaScript on the client side (tested with 
>>> IE 6 and Mozilla).
>> 
>> This is not acceptable for me. There are too many people blindly running 
>> JavaScript everywhere, and we should not enforce such bad behaviour.
>>
>> At least, you need a way to do it with plain old HTML (which is easy 
>> enough).
> 
> If the browser supports no JavaScript, the user can use all current
> features, except the new diff capabilities.
>
> My first thoughts where also about implementing it inside
> gitweb.cgi. This would mean a large change to the code, as all code
> which generate links needs to be adapted.
>
> Additionally, selecting a base object would mean, that you must submit
> a request to the server and probably return something (probable the
> same page, on which you selected the base object).

First, generating gitweb links in gitweb _all_ goes through href()
subroutine, so it would be fairly easy to implement it server side,
i.e. directly in gitweb.perl. One solution would be to set cookies
for parent (base) of diff server side. Another would be to pass
through diff parent (diff base) options (CGI parameters) in non-diff
views. It means that for example shortlog, or history, or summary
view would get 'hp', 'hpb', 'fp' parameters and pass it through
to "diff to selected base" links. But it is a fact that it would
mean additional request to the server to set the base object.

The correct solution I think which would satisfy everyone would
be to add plain HTML, i.e. server-side solution to "diff with
selected base" if this option is turned on. Then JavaScript would
replace it by JavaScript solution (or would add JavaScript solution
if server-side solution is turned off), again subject to gitweb
configuration. JavaScript would use cookies if possible, and changing
location if not (that is for discussion).

> For me, this would be no problem, but for high load servers (eg. gitweb at
> kernel.org), it would incread the system load.

I think use JavaScript if possible, and server-side implementation
if not would be good compromise.
 
> With JavaScript, this step needs no server interaction. Infact, a
> client could add the diff feature to any gitweb server with
> eg. greasemonkey, by injecting the JavaScript code.

Well, we could always put this in contrib/ as Greasmonkey script ;-)

>> Also I'd like to know: is there any reason you did not send a proper diff, 
>> given that you are so interested in diffs?
> 
> I'm not interessted in generating patchs via gitweb. I want to examine
> and review differences between various branches/tags/commits/... .
> 
> The "pseudo" diff for gitweb.cgi was to illustrate, how to integrate
> gitweb.js. The whole thing is under development, so I have not created
> a clean version.

I'm just wondering why did you not used git for development. You have
to have git installed to test gitweb, and it would be best to have
git.git repository fetched to base your work on newest 'master' version
(or rather 'origin/master' or 'origin' version). So it would be natural
to use git to work on gitweb, and to send git patches.
 
> As I wrote in my last mail, I used blobdiff to generation tree diffs,
> which results in wrong/missing file names. In the mean time, I've
> create a first version of a treediff function for gitweb.

Which is IMVHO long way from ready.

> --- old/gitweb.js   2007-03-17 15:18:23.284317140 +0100
> +++ gitweb.js        2007-03-17 22:25:18.254190096 +0100

First, if you don't use git to generate diffs, could you _please_
use equal depth paths patches, i.e. either 

 --- gitweb.js.orig   2007-03-17 15:18:23.284317140 +0100
 +++ gitweb.js        2007-03-17 22:25:18.254190096 +0100

or

 --- old/gitweb.js   2007-03-17 15:18:23.284317140 +0100
 +++ new/gitweb.js   2007-03-17 22:25:18.254190096 +0100


> --- ../mirror/git.git/gitweb/gitweb.perl	2007-03-12 22:06:44.000000000 +0100
> +++ gitweb.cgi	2007-03-17 18:41:50.000000000 +0100

The same as above (or even worse)

> @@ -1835,6 +1837,7 @@
>  		close $fd;
>  	}
>  
> +	print '<script type="text/javascript" src="gitweb.js"></script>';
>  	print "</body>\n" .
>  	      "</html>";
>  }

I'd rather have end of line after closing '</script>', and have scripts
in the head section, not in body.

> @@ -4191,6 +4194,106 @@
>  	git_commitdiff('plain');
>  }
>  
> +sub git_treediff {
> +	my $format = shift || 'html';
[...]

You base git_treediff on git_commitdiff. On one hand it is right, as
treediff is like commmitdiff, but without commit message, nor link to
commit parents.

On the other hand you should be able to handle 'hb', 'hpb', 'f', 'fp'
parameters like git_blobdiff does. And making git_difftree work between
two different trees from two different commits (e.g. git-gui/ in git.git
mainline and / in git-gui.git mainline) is not that easy...

-- 
Jakub Narebski
Poland
