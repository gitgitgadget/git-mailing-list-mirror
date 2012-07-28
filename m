From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Change canonicalize_url() to use the SVN 1.7 API
 when available.
Date: Sat, 28 Jul 2012 14:30:29 -0500
Message-ID: <20120728193029.GB3107@burratino>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino>
 <50143700.80900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:31:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvCjR-0003nU-LQ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 21:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab2G1Tah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 15:30:37 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53649 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab2G1Tag (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 15:30:36 -0400
Received: by ghrr11 with SMTP id r11so4060901ghr.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GvM6I71YSwd9dxBe8xP0m0HTvwU4ufmWlVWYaRA2ve0=;
        b=BRoLS8e99gxpLxBc5e4DZpl14ODGXxWCUSZd2fGuq9lLrebmI6NfyrkbeWknRYRcmZ
         x0ZUo5oqP6wDT2kgwcb8nf9MMmU4wFwXHv2u39Bz/bp4/2Uj8DkFPsPYoC8Bz5ie4iay
         UQ2UShT76Nnq1lfDGo7IyCTnOGq6Ccqsq7RKO8m5AzbxcZa1y6LWbIB7Nm4KumZa6ZQ/
         GyqNSlxeoCI2lx4EKnk6eQtBvbopyLhmIyshnpA5TA8ynjY6vcKhk8PUDC7wRwuHwnxa
         wZoqWh2mvl8tLdRfWm52jReO/+Tb40DtaF7h+1wcpOxkh6ek2qwgD7FnlScmiE3H0BzG
         94XA==
Received: by 10.43.126.1 with SMTP id gu1mr4059985icc.6.1343503836046;
        Sat, 28 Jul 2012 12:30:36 -0700 (PDT)
Received: from burratino ([64.107.3.126])
        by mx.google.com with ESMTPS id qo3sm5061608igc.8.2012.07.28.12.30.34
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 12:30:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50143700.80900@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202458>

Michael G Schwern wrote:
> On 2012.7.28 6:50 AM, Jonathan Nieder wrote:

>> If I am reading Subversion r873487 correctly, in ancient times,
>> svn_path_canonicalize() did the appropriate tweaking for URIs.  Today
>> its implementation is comforting:
>> 
>> 	const char *
>> 	svn_path_canonicalize(const char *path, apr_pool_t *pool)
>> 	{
>> 	  if (svn_path_is_url(path))
>> 	    return svn_uri_canonicalize(path, pool);
>> 	  else
>> 	    return svn_dirent_canonicalize(path, pool);
>> 	}
[...]
> I didn't know about that.  I don't know what your SVN backwards compat
> requirements are, but if that behavior goes back far enough in SVN to satisfy
> you folks, then canonicalize_url() should fall back to
> SVN::_Core::svn_path_canonicalize().

svn_path_canonicalize() has been usable for this kind of thing since
SVN 1.1, possibly earlier.

>                                      But try it at the end of the patch
> series.  The code has to be prepared for canonicalization first.  Then how it
> actually does it can be improved.

Since this part of the series is not tested with SVN 1.7, this is
basically adding dead code, right?  That could be avoided by
reordering the changes to keep "canonicalize_url" as-is until later in
the series when the switchover is safe.

Thanks.  Will play around with this code more.

Jonathan
