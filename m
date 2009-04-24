From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: filter escapes from longer commit titles that break firefox
Date: Sat, 25 Apr 2009 00:10:44 +0200
Message-ID: <200904250010.46299.jnareb@gmail.com>
References: <1239985473-666-1-git-send-email-paul.gortmaker@windriver.com> <200904241953.37187.jnareb@gmail.com> <20090424194822.GA15846@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:12:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxTdB-0008RY-Ob
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbZDXWKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbZDXWKw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:10:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:46328 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbZDXWKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:10:51 -0400
Received: by fg-out-1718.google.com with SMTP id 16so256448fgg.17
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uLr/vVdeMVMj7geDcJ7l11uClvKukceP8I1LWwNUbP4=;
        b=DaA+Dn2l7GqMfQi7tD6IWhxphT/9h3qAcuYUmFRdRliY3faSjJ/lqkW7tqnQX6udc4
         CQL209vZK5Dwclm6a4+RWs0jvjhyGFbMTRftGJObC5E3QSa/SLbcK5ybbBAJU2Xzuc0b
         fROIuXpKLdDyv9YVOOW8R3+wR8muvfMZrbo5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=v3dwL5NBu0m4f08rHuLzE85tCO9n2JW707Xgst+k2zq+SnQUCM9TevMFadKM0JA29L
         Q5f5BoJvB2wMNIimA1u4vcGNGQ8qDVNufONFn7AWKzdbZsb26sxU6xRRw0ns95wrIPdN
         VEMOG4Qgt4+qbdAmnr5mVoydXx61e3Esu44gY=
Received: by 10.86.95.20 with SMTP id s20mr1204618fgb.19.1240611048982;
        Fri, 24 Apr 2009 15:10:48 -0700 (PDT)
Received: from ?192.168.1.13? (abrz154.neoplus.adsl.tpnet.pl [83.8.119.154])
        by mx.google.com with ESMTPS id 3sm1962086fge.10.2009.04.24.15.10.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 15:10:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090424194822.GA15846@windriver.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117499>

On Fri, 24 April 2009, Paul Gortmaker wrote:
> [Re: [PATCH] gitweb: filter escapes from longer commit titles that break firefox]
> On 24/04/2009 (Fri 19:53) Jakub Narebski wrote:  
>> On Mon, 20 April 2009, Paul Gortmaker wrote:
>>> Jakub Narebski wrote:
>>>> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>>>>
>>>>   
>>>>> If there is a commit that ends in ^X and is longer in length than
>>>>> what will fit in title_short, then it doesn't get fed through
>>>>> esc_html() and so the ^X will appear as-is in the page source.
>>>>>
>>>>> When Firefox comes across this, it will fail to display the page,
>>>>> and only display a couple lines of error messages that read like:
>>>>>
>>>>>    XML Parsing Error: not well-formed
>>>>>    Location: http://git ....
>>>>>
>>>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

>>>> And I think that issue might be a bug elsewhere in gitweb if we have
>>>> text output which is not passed through esc_html... or bug in CGI.pm
>>>> if the error is in not escaping of -title _attribute_ (attribute
>>>> escaping has slightly different rules than escaping HTML, and should
>>>> be done automatically by CGI.pm).

>> What more important is: can you find out in more detail _where_
>> an error (unescaped control character) occurs: is it tag contents or
>> 'title' attribute for some tag, what tag is it (name and class), in
>> what view or views this bug is present, and in which part this occur?
>> Without those details it would b much harder to diagnose this bug...
> 
> No problem -- It appears to be in the title attribute, and it appears
> straight away when I go to the toplevel view of the repo, assuming that
> the commit is within the top 10 recent commits that are shown on the
> summary page.  I've put more details below on how I can reproduce it
> and the page source deltas -- hopefully this will help.  If there is
> something else I can provide that would help, don't hesitate to ask.

Ahh... that is what I thought.

The problem that we have to solve to fix this bug is twofold:

 * CGI.pm does by default slight escaping (simple_escape from CGI::Util)
   of _attribute_ values, but for obvious reasons it cannot do
   unconditional escaping of tag _contents_ (because it can be HTML
   itself).

   This escaping, at least in CGI.pm version 3.10 (most current version
   at CPAN is 3.43), is minimal: only '"', '&', '<' and '>' are escaped
   using named HTML entity references (&quot;, &amp;, &lt; and &gt;
   respectively).  simple_escape does not do escaping of control
   characters such as ^X which are invalid in XHTML (in strict mode).
   Note that IIRC escaping '<' and '>' in attributes is not strictly
   necessary.

   Gitweb relies on the fact that CGI.pm does escaping of attribute
   values.  We cannot escape attributes (e.g. "title" attribute with
   (almost) full commit subject) as it is now, because it would lead
   to double escaping.  Fortunately it is possible to turn off
   autoescaping by using $cgi->autoEscape(undef); note however that
   we would have to do attribute escaping by ourself in the scope of
   this declaration.

 * Rules for escaping attribute values are slightly different for rules
   for escaping HTML.  For attribute values we have to escape '"'
   because it is attribute delimiter, and '&' because it is escape
   character; escaping '<' and '>' is not strictly necessary.  For
   escaping HTML we need to escape '<' and '>' because they introduce
   tags, and '&' because it is escape character; escaping '"' is not
   strictly necessary.  It does not make sense to replace spaces by
   &nbsp; in attribute values, although it shouldn't harm.  OTOH we
   should perhaps escape newlines in attribute values.

   For esc_html and esc_path we replace (currently) control characters
   by character escape codes (e.g. "\f" for form-feed, "\0" for NUL,
   hexadecimal escapes for 'other' control characters).  But it is not
   the only possible solution.  We can use Unicode printable
   representation of control characters instead (0x2400 sheet).  Or we
   can use control key sequence / caret notation e.g. ^X for \0x18,
   or ^L for "\f" there.  We probably should discus this in more detail.

So it is not that simple...


P.S. The subject (one line summary of this change) should be also
changed to for example "gitweb: escape control characters in attributes"
and in commit message itself you should explain that control characters
break rendering in Firefox in strict XML compliance mode... or something
like that.
-- 
Jakub Narebski
Poland
