From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] fast-import: tighten parsing of mark references
Date: Wed, 4 Apr 2012 21:24:22 -0500
Message-ID: <20120405022422.GB20687@burratino>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <20120405015121.GA10945@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 04:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFcNG-0004bA-HS
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 04:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab2DECY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 22:24:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56775 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab2DECY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 22:24:28 -0400
Received: by iagz16 with SMTP id z16so1131578iag.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nwFQrB8IydgWvswU0Ol+TWzJlYxf2VskPtJCpldOlnM=;
        b=wsJWr0qZsiaPw8RNZT7GKSXR403TW3KChfvKFhNA4Q/49u60fWIBNdsueTsXKrtX7/
         Lo8peTF1EKrqnNw8uXmDn1+9PgtHCJnRY+s+bNjxK7xfe1Nlt3oS93lxggiYhJkLSVOm
         mzZxFAV6SkDcUa6d9n0X0D5tg2eRHHxppa6IlvukBCyctifqG8nMAwX519i0cWF99tWa
         KLhLSkMk6YjMxl0Hvq7OZa1kuKkMvN7ZD4fuZG3kubehFYtE0eotWjHupv2K4eHu18hU
         GQcGmu/x2eFMfztuuZKtuYYniABmOg6YNmMd/gmSfq/48Tw9PBVG9n45EjSBeNGvxFUQ
         POEw==
Received: by 10.50.197.132 with SMTP id iu4mr568985igc.4.1333592668272;
        Wed, 04 Apr 2012 19:24:28 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k8sm6884895igz.4.2012.04.04.19.24.25
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 19:24:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120405015121.GA10945@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194757>

Pete Wyckoff wrote:

> This addresses all of Jonathan's comments, in particular:

Nice.  Thanks much.  I only have a few small worries left:

[...]
> +++ b/t/t9300-fast-import.sh
> @@ -2635,4 +2635,280 @@ test_expect_success \
[...]
> +test_expect_success 'S: filemodify with garbage after sha1 must fail' '
> +	sha1=$(grep -w :103 marks | cut -d\  -f2) &&

"grep -w" isn't used elsewhere in the testsuite.  Is it portable?

[...]
> +# inline is misspelled; fast-import thinks it is some unknown dataref
> +# and complains "Invalid SHA1"
> +test_expect_success 'S: notemodify with garbage after inline dataref must fail' '
> +	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
> +	commit refs/heads/S
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	commit S note dataref inline
> +	COMMIT
> +	N inlineX :2
> +	data <<BLOB
> +	note blob
> +	BLOB
> +	EOF
> +	cat err &&
> +	test_i18ngrep "nvalid SHA1" err
> +'

If I understood the discussion before correctly, this error message is
suboptimal and something like "invalid dataref" would be a little
clearer, right?

That's orthogonal to what this patch is about so I'm not suggesting
changing it.  But shouldn't the test just check that fast-import fails
without committing to any particular message?

Cheers,
Jonathan
