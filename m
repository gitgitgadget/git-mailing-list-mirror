From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2012, #02; Wed, 6)
Date: Wed, 6 Jun 2012 19:39:04 -0500
Message-ID: <20120607003904.GB4065@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 02:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScQks-0003Ri-Ij
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 02:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab2FGAjJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 20:39:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51207 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2FGAjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 20:39:08 -0400
Received: by yenm10 with SMTP id m10so28924yen.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 17:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vhUQLMI0Pvj7kZvvkjiBCV4a8hnSusVK5/jmKMBwzIU=;
        b=Z1E5/wkILYVX9EBaH9s4gk9JmmQu2nQhTJrztqBl+eyl/IMAMy+RBlGDjv206zHYCj
         S9umT1+gavEnwuyYL7P8QI+LFv/3RlTjWNobNEYUPckCSiAdHnvvgf9RjyJ/QO3SrBG6
         SmWLBY916qpNfiLvncXDMRFSrMQRlxrXeZOWGny5nXMTH6OiDrF+jtMWaguaWPkYBfpU
         yfgj4DccLaVCVtjkvHY87t28rwt/g8pHKwn7jIWGv9RVs28wRZy6e1l/4XUD4lGChyUs
         u/2cxQv8O9frt79+XQd9dTVdpjirHtsJuP7L3z/svv9LNC783DEa/sSulRr+e/Wc36mY
         9pgQ==
Received: by 10.50.156.194 with SMTP id wg2mr80182igb.46.1339029547340;
        Wed, 06 Jun 2012 17:39:07 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id z7sm2235104igb.3.2012.06.06.17.39.06
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 17:39:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199363>

Hi,

David Michael Barr wrote:
> On Thu, Jun 7, 2012 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:

>> * db/vcs-svn (2012-06-01) 6 commits
>> =C2=A0- vcs-svn: drop no-op reset methods
>> =C2=A0- vcs-svn: fix signedness warnings
>> =C2=A0- vcs-svn: prefer strstr over memmem
>> =C2=A0- vcs-svn: prefer constcmp to prefixcmp
>> =C2=A0- vcs-svn: simplify cleanup in apply_one_window()
>> =C2=A0- vcs-svn: fix clang-analyzer error
>>
>> I do not know the doneness of this series that came out of the
>> blue. =C2=A0Are people involved in vcs-svn happy with this series?
>
> At the end of this series, vcs-svn is static-analyzer clean when
> merged into svn-dump-fast-export.

Thanks for the cc.  I generally like the code and generally dislike
the descriptions which amount to "appease the static analyzer" and
don't reflect the thought you actually put into the patches, which
sets a bad precedent.  I was planning to munge the descriptions, ask
you to look it over, and then ask Junio to pull.

The signedness patch still leaves me worried: for example, where len
is of type (size_t) and delta_len of type (off_t *),

	-       if (len > *delta_len ||
	+       if ((off_t) len > *delta_len ||

changes the meaning for the worse if len is very large on a system
(think: 64-bit PC) where size_t and off_t have the same width.  It's
exploitable. :(

But I like the spirit of the patches.

The "drop no-op reset methods" patch is unrisky and could go in
directly.

Jonathan
