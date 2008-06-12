From: Johannes Sixt <j.sixt@viscovery.net>
Subject: git diff --cc bug
Date: Thu, 12 Jun 2008 13:48:10 +0200
Message-ID: <48510CFA.3060101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 13:49:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6lJ8-0002Z2-In
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 13:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYFLLsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 07:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbYFLLsN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 07:48:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:15739 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbYFLLsN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 07:48:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K6lHn-0008Q8-Ac
	for git@vger.kernel.org; Thu, 12 Jun 2008 13:48:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP id 1D7D569F
	for <git@vger.kernel.org>; Thu, 12 Jun 2008 13:48:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84745>

While resolving a conflict, I noticed this output of 'git diff':

@@@ -109,7 -130,8 +114,8 @@@ void CValuesView::UpdateValues...
  	lvc.mask = LVCF_TEXT;
  	lvc.pszText = const_cast<LPTSTR>(static_cast<LPCTST...
 -	m_table.SetColumn(1, &lvc);
 +	GetListCtrl().SetColumn(1, &lvc);
+ 	m_columnTitles[1].id = valuesHeader;
  }


@@@ -635,31 -865,171 +641,169 @@@ void CValuesView::EraseVa...
 -LRESULT CValuesView::OnOptionsChanged(WPARAM, LPARAM)
 -{
 -	if (GetDocument()->ShowPointerValues()) {
 -		// invalidate values in the display
 -		CPoint pt(m_x, m_y);	// will be erased
 -		InvalidateValues();
 -		FindFmtStrings();
 -		Update(pt.x, pt.y);
 -	}
 -	return 0;
 -}
 -
  void CValuesView::OnUpdate(CView* pSender, LPARAM lHint, ...
  {
  	switch (lHint) {
++<<<<<<< HEAD:SomUI/ValuesWnd.cpp
++=======
+ 	case UPDATE_MONITORFRAME:
+ 		{
(hunk truncated for exposition)

Notice that there are no context lines at the beginning of the second
hunk. I would not have expected this, and I think it's a bug in git diff.

I don't feel like diving into the diff machinery, and would appreciate if
someone could have a closer look. I have prepared a small repository to
reproduce the behavior, but I don't want to post it to the public.

-- Hannes
