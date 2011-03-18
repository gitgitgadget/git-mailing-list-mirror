From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 2/3] gitweb: introduce localtime feature
Date: Fri, 18 Mar 2011 22:58:39 +0100
Message-ID: <201103182258.43368.jnareb@gmail.com>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost> <201103181540.03431.jnareb@gmail.com> <7vy64cwal7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:59:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0hhJ-0003LI-EC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816Ab1CRV66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 17:58:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37682 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800Ab1CRV65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 17:58:57 -0400
Received: by wwa36 with SMTP id 36so5396082wwa.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+S+RNQN653GPZVZpBMyUmMJBBg+5EQvRfuDLs3qzvRA=;
        b=Ln9Te6j+iCn9Mpyg3lGcKq7txMLwkpbMLMPd1vH1UTWBDRdtoMeEamuCDcVPO29PlA
         r7iwKOvWGWkVNusOdpoJBspcxhECHEa74i9Wu1rc9xNn5Nwlh7i8+r4SKhd1vyA4cZFE
         UVWkfbeqqFILH38lJ8JuQW3lIAj7pghryUE+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=euvEULeRkj3PnUMKtBTT6SjScym4T102SToFovp41qRsgO7iSD79S91swk+xW4eOyA
         RYnO0VjTxuIy1/O6Oz5b9AW6xTzlNNh1R9/4tLoUOjcSDAbupP3XCABf2Zr676njqVgJ
         hWIva+Sbed4DxBElq6eJV25G9shelJcKbgtso=
Received: by 10.227.202.80 with SMTP id fd16mr1646802wbb.229.1300485536025;
        Fri, 18 Mar 2011 14:58:56 -0700 (PDT)
Received: from [192.168.1.13] (abuz4.neoplus.adsl.tpnet.pl [83.8.197.4])
        by mx.google.com with ESMTPS id bd8sm1563000wbb.18.2011.03.18.14.58.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 14:58:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy64cwal7.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169368>

On Fri, 18 March 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

> > With this feature enabled, all timestamps are shown in the local
> > timezone instead of GMT.  The timezone is taken from the appropriate
> > timezone string stored in the commit object.
> >
> > This is useful if most of contributors (to a project) are based in a
> > single office, all within the same timezone.  In such case local time
> > is more useful than GMT / UTC time that gitweb uses by default, and
> > which is better choice for geographically scattered contributors.
[...]

> Thanks for moving the explanation up into the log message.  Much easier to
> understand the motivation.
 
> > @@ -2930,6 +2943,12 @@ sub parse_date {
> >  	$date{'iso-tz'} = sprintf("%04d-%02d-%02d %02d:%02d:%02d %s",
> >  	                          1900+$year, $mon+1, $mday,
> >  	                          $hour, $min, $sec, $tz);
> > +
> > +	if (gitweb_check_feature('localtime')) {
> > +		$date{'rfc2822'} = sprintf "%s, %d %s %4d %02d:%02d:%02d $tz",
> > +		                   $days[$wday], $mday, $months[$mon],
> > +		                   1900+$year, $hour ,$min, $sec;
> > +	}
> >  	return %date;
> >  }

> (hint: when reviewing, look a bit wider outside the context
> provided by the patch):

I was concentrating mainly on providing good commit message, but I should
probably review also code/change of 2/3 and 3/3 patches as a whole.

> Two comments: 
> 
>  - This gets seconds-since-epoch and returns a bag of pieces of formatted
>    timestamp (some are mere elements like "hour", some are full timestamp
>    like "iso-8601").  Doesn't sound like "parse"-date, does it?

That's right.  This 2/3 commit, and even more the next 3/3 one shows that
handling dates in gitweb really needs refactoring.  date_parse does both
parsing date and formatting dates, something that made difficult to do
3/3 easily and obviously.

The correct solution would be to replace current 2/3 and 3/3 by two commits:
first refactoring that separates parsing date from formatting date, and
second that introduces 'localtime' feature and brings changes to only 
single place: the new date formatting subroutine.

>  - It looks somewhat ugly to unconditionally assign to 'rfc2822' first
>    (before the context of the hunk) and then overwrite it.  Wouldn't it be
>    more useful later to have a separate 'rfc2822_local' field, just like
>    existing 'hour_local' and 'minute_local' are counterparts for 'hour'
>    and 'minute'?

And similar to 'iso-8601' vs 'iso-tz'.

This would not be needed with proposed by you refactoring that makes
parse_date do only parsing of timestamp + timezone.
 
> > @@ -3992,7 +4011,7 @@ sub git_print_authorship_rows {
> >  		      "</td></tr>\n" .
> >  		      "<tr>" .
> >  		      "<td></td><td> $wd{'rfc2822'}";
> > -		print_local_time(%wd);
> > +		print_local_time(%wd) if !gitweb_check_feature('localtime');
> >  		print "</td>" .
> >  		      "</tr>\n";
> >  	}
> 
> Very confusing.  "Ok, we print local time. --ah, wait, only when localtime
> feature is not used???"
> 
> It turns out that the hijacking of $wd{'rfc2822'} made above already gives
> us the local time so this patch turns the meaning of print-local-time used
> here into additionally-print-local-time.

You are right that is very confusing.

> 
> Both call sites to print_local_time() follow this pattern:
> 
> 	print "... some string ..." .
>         	"... that is sometimes long ..." .
>                 "... and more but ends with $bag{'rfc2822'}";
> 	print_local_time(%bag); # perhaps if "some condition";
> 	print "... more string ...";
> 
> I am referring to "if (${opts-localtime})" in the existing code and
> "if !gitweb_c_f('localtime')" in this patch as "some condition".
> 
> It appears to me that it may be a better idea to hide the "rfc2822" part
> as an implementation detail behind a helper function, to make the above
> pattern to look perhaps like this:
> 
> 	print "... some string ..." .
>         	"... that is sometimes long ..." .
>                 "... and more but ends with " .
> 		timestamp_string(%bag, "some condition") .
> 	        "... more string ...";

Yes, it is better idea.


Note however that gitweb uses a few different date formats, and in some
places it really has to be rfc2822 and nothing else.

Those formats are:

 * 'RFC 2822' format used by 'log' view for author date, 
   no place for "atnight" without 'localtime' now;
   displayed with avatar (gravatar or picon) if enabled

 * 'RFC 2822' + local time, with optional "atnight" marker,
   the local time part is here to be able to put "atnight" warning;
   used by 'commit', 'commitdiff', 'tag' views;
   displayed with avatar (gravatar or picon) if enabled

Those two can use "atnight", second should use "atnight" both for
default case and when 'localtime' feature is enabled.

 * 'RFC 2822' format used by "last change" field in summary part
   of 'summary' view for a project; no avatar, but perhaps we would
   want to add relative change

 * Strange 'RFC 2822' + timezone in parentheses used by 'commitdiff_plain'
   view; we should probably use the same as git-format-patch, i.e. always
   localtime RFC2822 format.

 * 'iso-tz' format (ISO 8601, but with ' ' instead of 'Z' as timezone
   separator) is used in mouseover info in 'blame' view.

 * 'Short ISO format' (YYYY-MM-DD) is used together with relative date
   in many places; it is set during parse_commit.  Timezone not shown,
   but GMT is used.  In this place width is quite precious (longest is
   "NN months ago", I think).


 * RFC 2822 as value of 'Last-Modified:' HTTP header in 'feed' actions;
   I'd have to check if it should be in GMT always, and if it is RFC 2822
   or some variation.  

 * RFC 2822 is format used for dates ('pubDate', 'lastBuildDate') for RSS
   feed format.  I'm not sure if it can be localtime, or must be GMT

 * ISO 8601 in UTC / GMT version (with 'Z' as timezone) is used for
   'updated' and 'published' dates in Atom feeds.  I'd have to check
   if dates here must be in GMT.

-- 
Jakub Narebski
Poland
