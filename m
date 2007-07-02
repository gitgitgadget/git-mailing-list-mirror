From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [RFC] Update on builtin-commit
Date: Mon, 02 Jul 2007 12:51:22 -0400
Message-ID: <1183395082.30611.16.camel@hinata.boston.redhat.com>
References: <11833861634103-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0707021709120.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 18:51:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5P7d-0006JK-SW
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 18:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbXGBQvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 12:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbXGBQvb
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 12:51:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbXGBQva (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 12:51:30 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l62GpSsg015141;
	Mon, 2 Jul 2007 12:51:28 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l62GpSUg002423;
	Mon, 2 Jul 2007 12:51:28 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l62GpSIc016897;
	Mon, 2 Jul 2007 12:51:28 -0400
In-Reply-To: <Pine.LNX.4.64.0707021709120.4071@racer.site>
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51382>

On Mon, 2007-07-02 at 17:11 +0100, Johannes Schindelin wrote:
> just a quick comment on the option parser:
> 
> On most platforms, sizeof(void*)>=sizeof(int). But I would not rely on 
> that. Rather (also because it is prettier), I'd use "union".

In the OPTION_INTEGER case, the 'value' void pointer points to an
integer global that's set to the value passed.  In the OPTION_NONE, it
also points to an integer, which is set to 1 if the option is seen.  So
I'm relying on sizeof(void*) == sizeof(int*), but I'm not storing ints
in pointers.

> Besides, your option parser loses order information, correct? IOW, 
> something like "--color --no-color --color" would confuse it.

Yes, I don't record the order of options, but in the builtin-commit
case, I don't think there are any options where that makes a difference?
In cases where order is important or we have an option that negates the
effect of another option (your --no-color example), we could either 1)
extend the option struct with a 'disable' name that flips the value back
to 0 or 2) instead of just setting it to 1, record the index of the
options passed and compare the indexes of conflicting options to see
which one was passed last.

Kristian
