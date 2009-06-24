From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 3/3] gitweb: gravatar url cache
Date: Wed, 24 Jun 2009 15:02:15 -0700
Message-ID: <7v63elqoig.fsf@alter.siamese.dyndns.org>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1245878183-2967-3-git-send-email-giuseppe.bilotta@gmail.com>
	<1245878183-2967-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 00:37:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJb60-0004kA-6H
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 00:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbZFXWhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 18:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbZFXWhX
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 18:37:23 -0400
Received: from fed1rmmtai113.cox.net ([68.230.241.47]:35079 "EHLO
	fed1rmmtai113.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZFXWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 18:37:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090624220217.YGLP2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 24 Jun 2009 18:02:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7y2F1c00e4aMwMQ03y2FSv; Wed, 24 Jun 2009 18:02:16 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=TPKOCYBqXYMA:10 a=pGLkceISAAAA:8
 a=iZZRpOtV_LicJTdvOFcA:9 a=1NBvuF5WHzaQfxQagF52K9ImviwA:4 a=MSl-tDqOz04A:10
 a=4D4lEYhtXrhF4MOF:21 a=nVOxDr-D9F52U7TN:21
X-CM-Score: 0.00
In-Reply-To: <1245878183-2967-4-git-send-email-giuseppe.bilotta@gmail.com> (Giuseppe Bilotta's message of "Wed\, 24 Jun 2009 23\:16\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122165>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Views which contain many occurrences of the same email address (e.g.
> shortlog view) benefit from not having to recalculate the MD5 of the
> email address every time.
> ---

Sign-off?

I think the cache is placed at the wrong level (it doesn't have to be a
GRavatar_url_cache, but can be a general avatar_url_cache).

IOW,

	our %avatar_url_cache = ();
        sub git_get_avatar {
        	...
                my $url;
                if (!exists $avatar_url_cache{$email}) {
                	if ($git_gravatar_enabled) {
                        	$url = ... gravatar stuff ...;
			} else if ($git_whatever_enabled) {
                        	$url = ... other stuff ...;
			}
                        $avatar_url_cache{$email} = $url;
		}
                $url = $avatar_url_cache{$email};
                if (defined $url) {
                	return ... prefix then $url then suffix ...;
                } else {
                	return "";
                }
	}

But the basic idea is sound, I think.
