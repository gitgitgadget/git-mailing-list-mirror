From: Joseph Leong <josephcleong@gmail.com>
Subject: Confirm my false error suspicions of Gitweb query injection
Date: Mon, 10 Sep 2012 09:45:08 -0700
Message-ID: <CAMOg_eUjmnisevN+AaArz+6TMpWYJL660xwG0ptEaTO7stcL6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 18:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB76v-0004Dr-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768Ab2IJQpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:45:12 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57965 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab2IJQpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:45:09 -0400
Received: by vbbff1 with SMTP id ff1so2874421vbb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=r+ppnNzZFtNG6ZARI3udtetUMOFFZNHVJL+B9TMCmnY=;
        b=c3wVsGt6qHzIQbC3W3EMkANLbo+2nnUyrN+VYO/eKSVt5576dqPXfQEF7b621D2M/P
         TaIgGZOKTslGo6kRd3hcOxIYJ8KVeRl/RTEvAusGCVsNWRa92geZNw9mrovbSoD5p3dS
         ORC+ajKKpqeasVIafcx7zh2CVNRdiD3cTjxERJjfzqdU13hKvD9uGnzZ2k2MZ8Y9V+h1
         7F+vtb2FswmQAhEtPqd6ESyn1Dtt1g9A3oNoxuQffDHqRzBW6epmQ2NG7tU4Lcqm4qDB
         HOxtulxjHq9N9cTJdswMApOqvTIhd1beIutCUiizHEfAmibxfbExIwk6WyRgMGRkYZF9
         +gbg==
Received: by 10.58.4.33 with SMTP id h1mr22487581veh.38.1347295508417; Mon, 10
 Sep 2012 09:45:08 -0700 (PDT)
Received: by 10.220.207.220 with HTTP; Mon, 10 Sep 2012 09:45:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205145>

Hi Everyone,

I'm using Gitweb (Based on Git 1.7.9 on RHEL 5.8).

I was poking around and tried a GET Request (REQ) with some SQL
statements as a search query and noticed a 500. Can i just confirm
with anyone here that the error message I'm seeing in the Response
(RESP) is basically saying that the search parameters are invalid
because of it's funny chars are breaking the regex search and that
it's not anything database related.  Thank you!

[REQ]
GET /git/?s=%28select+1234%2C HTTP/1.0

[RESP]
500 - Internal Server Error
Unmatched ( in regex; marked by &lt;-- HERE in m/( &lt;-- HERE select
1234,/ at /var/www/git/gitweb.cgi line 4845.

[Code at gitweb.cgi line 4845]
next if $searchtext and not $pr->{'path'} =~ /$searchtext/ and not
$pr->{'descr_long'} =~ /$searchtext/;
