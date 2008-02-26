From: David Greaves <david@dgreaves.com>
Subject: Correcting timestamps when importing archives to git
Date: Tue, 26 Feb 2008 11:45:08 +0000
Message-ID: <47C3FBC4.4030206@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 12:45:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTyFt-0006Hy-F6
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 12:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbYBZLpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 06:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbYBZLpL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 06:45:11 -0500
Received: from mx1.ukfsn.org ([77.75.108.10]:37032 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752236AbYBZLpK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 06:45:10 -0500
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id D3D86DEC2C
	for <git@vger.kernel.org>; Tue, 26 Feb 2008 11:47:10 +0000 (GMT)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id W4kATZ+oLu9N for <git@vger.kernel.org>;
	Tue, 26 Feb 2008 11:33:58 +0000 (GMT)
Received: from elm.dgreaves.com (i-83-67-36-194.freedom2surf.net [83.67.36.194])
	by mail.ukfsn.org (Postfix) with ESMTP id AA982DEBB7
	for <git@vger.kernel.org>; Tue, 26 Feb 2008 11:47:10 +0000 (GMT)
Received: from ash.dgreaves.com ([10.0.0.90])
	by elm.dgreaves.com with esmtp (Exim 4.62)
	(envelope-from <david@dgreaves.com>)
	id 1JTyFA-00071L-MA
	for git@vger.kernel.org; Tue, 26 Feb 2008 11:45:08 +0000
User-Agent: Mozilla-Thunderbird 2.0.0.6 (X11/20071009)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75123>

Hi

I recently converted a set of patches to a git repository.

In order to use the correct timestamps my script used a 'faketime' solution I
found here:
  http://www.code-wizards.com/projects/libfaketime/

I used a perl subroutine that takes a time (obtained by stat()ing the original
patch or looking in logs) and then the normal 'system()' args.

sub faketime_system {
    my $time=shift;

$ENV{"LD_PRELOAD"}="/everything/devel/faketime/libfaketime-0.6/libfaketime.so.1";
    $ENV{"FAKETIME_FMT"}='%s';
    $ENV{'FAKETIME'}=$time;
    system @_;
    $ENV{"LD_PRELOAD"}="";
}


so:
	$time=(stat("$tarfile"))[9];
	faketime_system ($time, "tar xfj $tarfile");

or:
    $time=(stat("$patchfile"))[9];
    faketime_system ($time, "zcat $patchfile | patch -f -p1");
    faketime_system ($time, "git add .");

HTH someone else...

David
