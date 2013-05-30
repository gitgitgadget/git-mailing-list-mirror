From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/6] t/send-email.sh: add test for suppress self
Date: Thu, 30 May 2013 07:51:54 +0300
Message-ID: <20130530045154.GA6168@redhat.com>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
 <1369579187-27573-2-git-send-email-mst@redhat.com>
 <7vy5axr0mz.fsf@alter.siamese.dyndns.org>
 <20130529214403.GA5956@redhat.com>
 <7vmwrdqu9f.fsf@alter.siamese.dyndns.org>
 <7vip21qtnc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 06:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhupr-0005h0-N1
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 06:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab3E3Eva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 00:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845Ab3E3Ev3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 00:51:29 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4U4pQDU015726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 30 May 2013 00:51:26 -0400
Received: from redhat.com (vpn-203-5.tlv.redhat.com [10.35.203.5])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r4U4pOFL012940;
	Thu, 30 May 2013 00:51:25 -0400
Content-Disposition: inline
In-Reply-To: <7vip21qtnc.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225922>

On Wed, May 29, 2013 at 03:59:51PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> If we don't want to use \, this can also be done like this:
> >>
> >> FOO << EOF && 
> >> BLABLA
> >> EOF
> >>  BAR && 
> >>  VAR
> >>
> >> I think this is what you suggest.
> >
> > Yup, that is exactly what I meant (but no leading indentation before
> > BAR and VAR).
> >
> > That way, it is a lot more clear where the input is (the BLABLA is
> > fed to FOO and BAR and VAR do not have anything to do with it).
> >
> >>> > +		grep '^Cc:' msghdr1-$3 > actual-no-cc-$3 && \
> >>> > +		test_cmp expected-no-cc-$3 actual-no-cc-$3
> >
> > OK, so this is where the message begins, with the commit title "test
> > supress-cc.self...".
> 
> Another thing I forgot to say, if you are rerolling this patch
> anyway to follow that style, is that our newer tests typically
> write it like this:

What exactly should I notice here?

> test_supress_self () {
> 	test_commit $3 &&
>         test_when_finished "git reset --hard HEAD^" &&
>         write_script <<-EOF &&
>         sed -n -e s/^cccmd--//p \"\$1\"
> 	EOF
> 
> 	git commit --amend --author="$1 <$2>" -F - <<-EOF &&
> 	test suppress-cc.self $3 with name $1 email $2
> 
> 	$3
> 
> 	cccmd--"$1" <$2>
> 
>         Cc: "$1" <$2>
> 	Cc: $1 <$2>
> 	Signed-off-by: "$1" <$2>
> 	Signed-off-by: $1 <$2>
>         EOF
>         
>         clean_fake_sendmail &&
>         git format-patch --stdout -1 >"suppress-self-$3.patch" &&
>         git send-email --from="$1 <$2>" \
>         	--to=nobody@example.com \
>                 ... other args ...
>         ... verification steps for the send-email output ...
> }
