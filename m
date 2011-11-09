From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 3/3] commit-tree: teach -x <extra>
Date: Wed, 09 Nov 2011 17:19:00 -0500
Message-ID: <4EBAFC54.1090403@kitware.com>
References: <1320872495-7545-1-git-send-email-gitster@pobox.com> <1320872495-7545-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 23:19:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROGU9-0003O6-Kl
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 23:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab1KIWTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 17:19:03 -0500
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:55234 "HELO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751937Ab1KIWTC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2011 17:19:02 -0500
Received: from mail-gx0-f175.google.com ([209.85.161.175]) (using TLSv1) by na3sys009aob115.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTrr8U1zA66JaxXQYF8RJI4n02/LPziF0@postini.com; Wed, 09 Nov 2011 14:19:02 PST
Received: by mail-gx0-f175.google.com with SMTP id p1so2238616ggn.6
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 14:18:59 -0800 (PST)
Received: by 10.146.110.15 with SMTP id i15mr1942491yac.19.1320877139555;
        Wed, 09 Nov 2011 14:18:59 -0800 (PST)
Received: from [192.168.1.220] (66-194-253-20.static.twtelecom.net. [66.194.253.20])
        by mx.google.com with ESMTPS id c44sm9427702yhm.5.2011.11.09.14.18.58
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 14:18:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <1320872495-7545-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185172>

On 11/9/2011 4:01 PM, Junio C Hamano wrote:
> By feeding the header part of the original commit with this parameter,
> e.g. -x "$(git cat-file commit $commit | sed -n -e /^$/q -e p)", extra
> headers of another commit can be transplanted to the resulting commit.

One of the interface features typical in git plumbing that I've always liked
is that any place that can pass long strings tends to be implemented using
pipes or files, at least optionally.  This is especially helpful for operating
systems that have severe limitations on total command line size.

I suggest a flag (-X ?) that tells commit-tree to treat the commit message
(from wherever it is read) in "cat-file commit" format.  Read the extra
header lines from the part before the blank line, and the rest of the message
normally after the blank line.  For example:

  (git cat-file commit $commit | sed -n -e /^$/q -e p
   echo ''
   echo 'New commit message') |
  git commit-tree -X -p $parent $tree

If we want the original extended headers and the original message:

  git cat-file commit $commit | git commit-tree -X -p $parent $tree

-Brad
